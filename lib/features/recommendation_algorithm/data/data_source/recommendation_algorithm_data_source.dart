import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preference_app_group/shared_preference_app_group.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/constants/constants.dart';
import 'package:sureline/core/constants/quotes_data_files.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/general_settings/author_preferences/data/model/author_pref_model.dart';
import 'package:sureline/features/general_settings/muted_content/data/model/muted_content_model.dart';
import 'package:sureline/features/recommendation_algorithm/data/database/dao/author_prefs_table_dao.dart';
import 'package:sureline/features/recommendation_algorithm/data/database/dao/muted_content_table_dao.dart';
import 'package:sureline/features/recommendation_algorithm/data/database/dao/quotes_dao.dart';
import 'package:sureline/features/recommendation_algorithm/data/model/quote_model.dart';

abstract class RecommendationAlgorithmDataSource {
  Future<Either<Failure, void>> initialize();
  Future<Either<Failure, List<QuoteModel>>> getQuotes(int page);
  Future<Either<Failure, void>> markQuoteAsShown(int id);
  Future<Either<Failure, List<QuoteModel>>> getShownQuotes();

  Future<Either<Failure, void>> updateAuthorPreference(
    AuthorPrefModel authorPrefModel,
  );
  Future<Either<Failure, List<AuthorPrefModel>>> getAuthorPreferences();
  Future<Either<Failure, void>> updateMutedContent({
    required bool withAuthor,
    required bool withoutAuthor,
  });
  Future<Either<Failure, List<MutedContentModel>>> getMutedContent();
}

class RecommendationAlgorithmDataSourceImpl
    extends RecommendationAlgorithmDataSource {
  final QuotesDao quotesDao;
  final AuthorPrefsTableDao authorPrefsTableDao;
  final MutedContentTableDao mutedContentTableDao;

  RecommendationAlgorithmDataSourceImpl(
    this.quotesDao,
    this.authorPrefsTableDao,
    this.mutedContentTableDao,
  );

  @override
  Future<Either<Failure, void>> initialize() async {
    try {
      final existingQuotes = await quotesDao.getAllQuotes();

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
            ),
          );
        }

        await authorPrefsTableDao.initializeAllAuthors();
        await mutedContentTableDao.initializeAllMutedContent();
        await _initializeQuoteAppGroup();
      }
      return Right(unit);
    } catch (e) {
      debugPrint(e.toString());
      return Left(UnknownFailure());
    }
  }

  Future<void> _shuffleAndRefreshQuotes() async {
    // Get ALL quotes from database
    final allQuotes = await quotesDao.getAllQuotes();
    final quoteCount = allQuotes.length;

    final List<int> shuffledOrder = List.generate(quoteCount, (index) => index)
      ..shuffle();

    for (int i = 0; i < allQuotes.length; i++) {
      await quotesDao.updateOrder(allQuotes[i].id, shuffledOrder[i]);
      await quotesDao.markQuoteAsNotShown(allQuotes[i].id);
    }
  }

  @override
  Future<Either<Failure, List<QuoteModel>>> getQuotes(int page) async {
    try {
      final now = DateTime.now();
      final offset = page * Constants.quotesPageSize;
      final newQuotes = await quotesDao.getAllNewQuotes();
      // If we have enough new quotes for this page, return them
      if (offset <= newQuotes.length &&
          newQuotes.length >= (offset + Constants.quotesPageSize)) {
        final startIndex = offset;
        final endIndex = (offset + Constants.quotesPageSize).clamp(
          0,
          newQuotes.length,
        );
        final pageQuotes = newQuotes.sublist(startIndex, endIndex);

        final quoteModels =
            pageQuotes.map((quote) => QuoteModel.fromQuote(quote)).toList();
        return Right(quoteModels);
      }

      // If we don't have enough new quotes, check if we have any remaining
      final remainingNewQuotes = newQuotes.length - offset;

      // If we don't have enough new quotes for a full page, recycle all quotes
      if (remainingNewQuotes < Constants.quotesPageSize) {
        // Store remaining new quotes in temp variable
        final remainingQuotes =
            remainingNewQuotes > 0 ? newQuotes.sublist(offset) : <Quote>[];

        await _shuffleAndRefreshQuotes();

        // Calculate how many more quotes we need to reach page size
        final quotesNeeded = Constants.quotesPageSize - remainingQuotes.length;

        // Get the additional quotes needed from the newly shuffled database
        final additionalQuotes = await quotesDao.getAllNewQuotes();
        final additionalQuotesNeeded =
            additionalQuotes.take(quotesNeeded).toList();

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
      final fallbackQuotes = await quotesDao.getAllQuotes();
      return Right(
        fallbackQuotes.map((quote) => QuoteModel.fromQuote(quote)).toList(),
      );
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
  Future<Either<Failure, List<QuoteModel>>> getShownQuotes() async {
    try {
      final shownQuotes = await quotesDao.getShownQuotes();
      return Right(
        shownQuotes.map((quote) => QuoteModel.fromQuote(quote)).toList(),
      );
    } catch (e) {
      debugPrint(e.toString());
      return Left(UnknownFailure());
    }
  }

  Future<List<QuoteModel>> _loadQuotesFromAssets() async {
    final files = QuotesDataFiles.files;

    final List<QuoteModel> allQuotes = [];

    for (final file in files) {
      final jsonStr = await rootBundle.loadString(file);
      final List<dynamic> jsonList = json.decode(jsonStr);
      print('jsonList is this $jsonList');
      allQuotes.addAll(jsonList.map((json) => QuoteModel.fromJson(json)));
    }
    return allQuotes;
  }

  @override
  Future<Either<Failure, void>> updateMutedContent({
    required bool withAuthor,
    required bool withoutAuthor,
  }) async {
    try {
      await mutedContentTableDao.updateMutedContent(
        MutedContentModel(
          isWithAuthorMuted: withAuthor,
          isWithoutAuthorMuted: withoutAuthor,
        ),
      );
      await _synchronizeQuotesWithPreferences();
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
    AuthorPrefModel authorPrefModel,
  ) async {
    try {
      await authorPrefsTableDao.updateAuthorPrefs(authorPrefModel);
      await _synchronizeQuotesWithPreferences();
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

  Future<void> _synchronizeQuotesWithPreferences() async {
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

    await _updateQuoteAppGroup();
  }

  Future<void> _initializeQuoteAppGroup() async {
    await _updateQuoteAppGroup();
  }

  Future<void> _updateQuoteAppGroup() async {
    final quotes = await quotesDao.getAllNewQuotes();
    final quoteTexts = quotes.map((quote) => quote.quoteText).toList();
    await SharedPreferenceAppGroup.setAppGroup(Constants.widgetAppGroup);
    await SharedPreferenceAppGroup.setStringList(
      SP.quotesDataAppGroup,
      quoteTexts,
    );
    await _saveThemeOnAppGroup();
    Utils.updateWidgets();
  }

  Future<void> _saveThemeOnAppGroup() async {
    try {
      await SharedPreferenceAppGroup.setAppGroup(
        'group.com.abdulmuiz.sureline.quoteWidget',
      );
      if (App.themeEntity.backgroundEntity.solidColor == null) {
        await SharedPreferenceAppGroup.remove(SP.solidColorAppGroup);
      } else {
        await SharedPreferenceAppGroup.setInt(
          SP.solidColorAppGroup,
          App.themeEntity.backgroundEntity.solidColor?.value,
        );
      }
      try {
        // final appGroupDir = await FlutterAppGroupDirectory.getAppGroupDirectory('group.com.abdulmuiz.sureline.quoteWidget',);
        // if (appGroupDir == null) return null;
        //
        // final XFile xFile = XFile(App.themeEntity.backgroundEntity.path!);
        // final fileName = p.basename(xFile.path) + '.png';
        // final destPath = p.join(appGroupDir.path, fileName);
        // debugPrint(destPath);

        // Save XFile to the destination path
        // await xFile.saveTo(destPath);

        await SharedPreferenceAppGroup.setString(
          SP.imagePathAppGroup,
          App.themeEntity.backgroundEntity.path,
        );
        await SharedPreferenceAppGroup.setInt(
          SP.textColorAppGroup,
          App.themeEntity.textDecorEntity.textColor.value,
        );
        await SharedPreferenceAppGroup.setInt(
          SP.textSizeAppGroup,
          App.themeEntity.textDecorEntity.fontSize.round(),
        );
      } catch (e) {
        debugPrint("Error saving image to App Group: $e");
      }
    } catch (e) {
      debugPrint('${e}');
    }
  }
}
