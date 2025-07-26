import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preference_app_group/shared_preference_app_group.dart';
import 'package:sureline/core/constants/constants.dart';
import 'package:sureline/core/constants/quotes_data_files.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/data/model/author_pref_model.dart';
import 'package:sureline/features/preferenecs/general_settings/muted_content/data/model/muted_content_model.dart';
import 'package:sureline/features/recommendation_algorithm/data/database/dao/author_prefs_table_dao.dart';
import 'package:sureline/features/recommendation_algorithm/data/database/dao/muted_content_table_dao.dart';
import 'package:sureline/features/recommendation_algorithm/data/database/dao/quotes_dao.dart';
import 'package:sureline/common/data/model/quote_model.dart';

abstract class RecommendationAlgorithmDataSource {
  Future<Either<Failure, void>> initialize({required bool isPremium});
  Future<Either<Failure, List<QuoteModel>>> getQuotes({
    int? page,
    int? limit,
    required bool isPremium,
  });
  Future<Either<Failure, void>> markQuoteAsShown(int id);
  Future<Either<Failure, List<QuoteModel>>> getShownQuotes({required bool isPremium});

  Future<Either<Failure, void>> updateAuthorPreference(
    AuthorPrefModel authorPrefModel, {
    required bool isPremium,
  });
  Future<Either<Failure, List<AuthorPrefModel>>> getAuthorPreferences();
  Future<Either<Failure, void>> updateMutedContent({
    required bool withAuthor,
    required bool withoutAuthor,
    required bool isPremium,
  });
  Future<Either<Failure, List<MutedContentModel>>> getMutedContent();
}

class RecommendationAlgorithmDataSourceImpl extends RecommendationAlgorithmDataSource {
  final QuotesDao quotesDao;
  final AuthorPrefsTableDao authorPrefsTableDao;
  final MutedContentTableDao mutedContentTableDao;

  RecommendationAlgorithmDataSourceImpl(
    this.quotesDao,
    this.authorPrefsTableDao,
    this.mutedContentTableDao,
  );

  @override
  Future<Either<Failure, void>> initialize({required bool isPremium}) async {
    try {
      final existingQuotes = await quotesDao.getAllQuotes(isPremium: isPremium);

      if (existingQuotes.isEmpty) {
        final quotes = await _loadQuotesFromAssets();
        quotes.shuffle();
        for (int i = 0; i < quotes.length; i++) {
          final quote = quotes[i];
          await quotesDao.addQuote(
            QuotesCompanion(
              quoteText: Value(quote.quoteText),
              author: Value(quote.author),
              order: Value(i),
              isPremium: Value(quote.isPremium),
            ),
          );
        }

        await authorPrefsTableDao.initializeAllAuthors();
        await mutedContentTableDao.initializeAllMutedContent();
        await _initializeQuoteAppGroup(isPremium: isPremium);
      }
      return Right(unit);
    } catch (e) {
      debugPrint(e.toString());
      return Left(UnknownFailure());
    }
  }

  Future<void> _shuffleAndRefreshQuotes() async {
    // Get ALL quotes from database
    final allQuotes = await quotesDao.getAllQuotes(isPremium: true);
    final quoteCount = allQuotes.length;

    final List<int> shuffledOrder = List.generate(quoteCount, (index) => index)..shuffle();

    for (int i = 0; i < allQuotes.length; i++) {
      await quotesDao.updateOrder(allQuotes[i].id, shuffledOrder[i]);
      await quotesDao.markQuoteAsNotShown(allQuotes[i].id);
    }
  }

  @override
  Future<Either<Failure, List<QuoteModel>>> getQuotes({
    int? page,
    int? limit,
    required bool isPremium,
  }) async {
    try {
      if (limit != null) {
        final quotes = await quotesDao.getAllQuotesWithLimit(limit, isPremium: isPremium);
        final quoteModels = quotes.map((quote) => QuoteModel.fromQuote(quote)).toList();
        return Right(quoteModels);
      } else if (page != null) {
        final now = DateTime.now();
        final offset = page * Constants.quotesPageSize;
        final newQuotes = await quotesDao.getAllNewQuotes(isPremium: isPremium);
        // If we have enough new quotes for this page, return them
        if (offset <= newQuotes.length && newQuotes.length >= (offset + Constants.quotesPageSize)) {
          final startIndex = offset;
          final endIndex = (offset + Constants.quotesPageSize).clamp(0, newQuotes.length);
          final pageQuotes = newQuotes.sublist(startIndex, endIndex);

          final quoteModels = pageQuotes.map((quote) => QuoteModel.fromQuote(quote)).toList();
          return Right(quoteModels);
        }

        // If we don't have enough new quotes, check if we have any remaining
        final remainingNewQuotes = newQuotes.length - offset;

        // If we don't have enough new quotes for a full page, recycle all quotes
        if (remainingNewQuotes < Constants.quotesPageSize) {
          // Store remaining new quotes in temp variable
          final remainingQuotes = remainingNewQuotes > 0 ? newQuotes.sublist(offset) : <Quote>[];

          await _shuffleAndRefreshQuotes();

          // Calculate how many more quotes we need to reach page size
          final quotesNeeded = Constants.quotesPageSize - remainingQuotes.length;

          // Get the additional quotes needed from the newly shuffled database
          final additionalQuotes = await quotesDao.getAllNewQuotes(isPremium: isPremium);
          final additionalQuotesNeeded = additionalQuotes.take(quotesNeeded).toList();

          // Combine remaining quotes with additional quotes
          final finalQuotes = [
            ...remainingQuotes.map((quote) => QuoteModel.fromQuote(quote)),
            ...additionalQuotesNeeded.map((quote) => QuoteModel.fromQuote(quote)),
          ];

          if (finalQuotes.length != Constants.quotesPageSize) {
            print('Final quotes length is not equal to page size');
          }

          return Right(finalQuotes);
        }

        // If no new quotes remaining, return all quotes as fallback
        print('falling back');
        final fallbackQuotes = await quotesDao.getAllQuotes(isPremium: isPremium);
        return Right(fallbackQuotes.map((quote) => QuoteModel.fromQuote(quote)).toList());
      } else {
        debugPrint('Both parameters cannot be null');
        return Left(UnknownFailure());
      }
    } catch (e) {
      debugPrint(e.toString());
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> markQuoteAsShown(int id) async {
    try {
      await quotesDao.markQuoteAsShown(id, DateTime.now());
      return Right(unit);
    } catch (e) {
      debugPrint(e.toString());
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<QuoteModel>>> getShownQuotes({required bool isPremium}) async {
    try {
      final shownQuotes = await quotesDao.getShownQuotes(isPremium: isPremium);
      return Right(shownQuotes.map((quote) => QuoteModel.fromQuote(quote)).toList());
    } catch (e) {
      debugPrint(e.toString());
      return Left(UnknownFailure());
    }
  }

  Future<List<QuoteModel>> _loadQuotesFromAssets() async {
    final files = QuotesDataFiles.files;
    final premiumFiles = QuotesDataFiles.premiumFiles;

    final List<QuoteModel> allQuotes = [];

    // Load regular quotes
    for (final file in files) {
      final jsonStr = await rootBundle.loadString(file);
      final List<dynamic> jsonList = json.decode(jsonStr) as List<dynamic>;
      allQuotes.addAll(jsonList.map((json) => QuoteModel.fromJson(json as Map<String, dynamic>)));
    }

    // Load premium quotes and mark as premium
    for (final file in premiumFiles) {
      final jsonStr = await rootBundle.loadString(file);
      final List<dynamic> jsonList = json.decode(jsonStr) as List<dynamic>;
      allQuotes.addAll(
        jsonList.map((json) {
          final map = Map<String, dynamic>.from(json as Map);
          map['isPremium'] = true;
          return QuoteModel.fromJson(map);
        }),
      );
    }
    return allQuotes;
  }

  @override
  Future<Either<Failure, void>> updateMutedContent({
    required bool withAuthor,
    required bool withoutAuthor,
    required bool isPremium,
  }) async {
    try {
      await mutedContentTableDao.updateMutedContent(
        MutedContentModel(isWithAuthorMuted: withAuthor, isWithoutAuthorMuted: withoutAuthor),
      );
      await _synchronizeQuotesWithPreferences(isPremium: isPremium);
      return Right(unit);
    } catch (e) {
      debugPrint(e.toString());
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<MutedContentModel>>> getMutedContent() async {
    try {
      final mutedContent = await mutedContentTableDao.getAllMutedContent();
      return Right(mutedContent);
    } catch (e) {
      debugPrint(e.toString());
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateAuthorPreference(
    AuthorPrefModel authorPrefModel, {
    required bool isPremium,
  }) async {
    try {
      await authorPrefsTableDao.updateAuthorPrefs(authorPrefModel);
      await _synchronizeQuotesWithPreferences(isPremium: isPremium);
      return Right(unit);
    } catch (e) {
      debugPrint(e.toString());
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<AuthorPrefModel>>> getAuthorPreferences() async {
    try {
      final authorPrefs = await authorPrefsTableDao.getAllAuthorPrefs();
      return Right(authorPrefs);
    } catch (e) {
      debugPrint(e.toString());
      return Left(UnknownFailure());
    }
  }

  Future<void> _synchronizeQuotesWithPreferences({bool? isPremium}) async {
    final mutedContent = await mutedContentTableDao.getAllMutedContent();
    if (mutedContent.isNotEmpty) {
      if (mutedContent.first.isWithAuthorMuted) {
        quotesDao.restrictAllQuotesWithAuthor();
      } else {
        quotesDao.liftRestrictionOnAllQuotesWithAuthor();
      }

      if (mutedContent.first.isWithoutAuthorMuted) {
        quotesDao.restrictAllQuotesWithoutAuthor();
      } else {
        quotesDao.liftRestrictionOnAllQuotesWithoutAuthor();
      }
    }

    final authorPrefs = await authorPrefsTableDao.getAllAuthorPrefs();
    for (final authorPref in authorPrefs) {
      if (authorPref.isPreferred) {
        // Increase score
      } else {
        // Decrease score
      }
    }

    await _updateQuoteAppGroup(isPremium: isPremium);
  }

  Future<void> _initializeQuoteAppGroup({bool? isPremium}) async {
    await _updateQuoteAppGroup(isPremium: isPremium);
  }

  Future<void> _updateQuoteAppGroup({bool? isPremium}) async {
    final quotes = await quotesDao.getAllNewQuotes(isPremium: isPremium ?? false);
    final quoteTexts = quotes.map((quote) => quote.quoteText).toList();
    await SharedPreferenceAppGroup.setAppGroup(Constants.widgetAppGroup);
    await SharedPreferenceAppGroup.setStringList(SP.quotesDataAppGroup, quoteTexts);
    await Utils.saveThemeOnAppGroup();
  }
}
