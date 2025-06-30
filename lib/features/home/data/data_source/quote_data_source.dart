import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preference_app_group/shared_preference_app_group.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/core/constants/constants.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/collections/data/model/collection_model.dart';
import 'package:sureline/features/recommendation_algorithm/data/model/quote_model.dart';

abstract class QuoteDataSource {
  Future<Either<Failure, void>> saveAllQuotesToAppGroup();

  Future<Either<Failure, List<QuoteModel>>> getQuotes();

  Future<Either<Failure, void>> setOnboardingToCompleted();

  Future<Either<Failure, bool>> isOnboardingComplete();

  Future<Either<Failure, void>> setSwipeToCompleted();

  Future<Either<Failure, bool>> isSwipeComplete();

  Future<Either<Failure, int>> incrementLikeCount();

  Future<Either<Failure, int>> decrementLikeCount();

  Future<Either<Failure, int>> getLikeCount();

  Future<Either<Failure, bool>> isLikeGuideShown();

  Future<Either<Failure, void>> setLikeGuideShown();

  Future<Either<Failure, bool>> isShareGuideShown();

  Future<Either<Failure, void>> setShareGuideShown();

  Future<Either<Failure, bool>> isFeedSetupShown();

  Future<Either<Failure, void>> setFeedSetupShown();

  Future<Either<Failure, void>> saveOwnQuote(QuoteModel model);
  Future<Either<Failure, void>> removeOwnQuote(QuoteModel newModel);

  Either<Failure, List<QuoteModel>?> getOwnQuote();

  Future<Either<Failure, List<QuoteModel>>> getRandomQuotes(int qty);

  Either<Failure, int> getLikedQuotesCount();

  Future<Either<Failure, List<QuoteModel>>> getQuotesSearchResults(
    String query,
    int page,
  );
}

class QuoteDataSourceImpl extends QuoteDataSource {
  final SharedPreferences prefs;

  QuoteDataSourceImpl(this.prefs);

  @override
  Future<Either<Failure, List<QuoteModel>>> getQuotesSearchResults(
    String query,
    int page,
  ) async {
    try {
      List<QuoteModel> allQuotes = await _loadQuotesFromAssets();
      allQuotes = [..._syncWithLikedQuotes(allQuotes)];
      List<QuoteModel> searchedQuotes = [];

      if (query.isEmpty) {
        searchedQuotes = [...allQuotes];
      } else {
        searchedQuotes =
            allQuotes
                .where(
                  (model) => model.quoteText.trim().toLowerCase().contains(
                    query.trim().toLowerCase(),
                  ),
                )
                .toList();
      }

      return Right(searchedQuotes);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  List<QuoteModel> _syncWithLikedQuotes(List<QuoteModel> quotes) {
    List<QuoteModel> finalQuotes = [...quotes];
    final likedQuotes = _getLikedQuotesList();

    if (likedQuotes == null) {
      return finalQuotes;
    }

    for (int i = 0; i < quotes.length; i++) {
      for (int j = 0; j < likedQuotes.length; j++) {
        if (quotes[i].quoteText == likedQuotes[j].quoteText) {
          // finalQuotes[i] = quotes[i].copyWith(isLiked: true);
          finalQuotes[i] = quotes[i].copyWith();
        }
      }
    }
    return finalQuotes;
  }

  Future<List<QuoteModel>> _loadQuotesFromAssets() async {
    final files = [
      'assets/data/jim_collins.json',
      'assets/data/napoleon_hill.json',
      'assets/data/peter_drucker.json',
    ];

    final List<QuoteModel> allQuotes = [];

    for (final file in files) {
      final jsonStr = await rootBundle.loadString(file);
      final List<dynamic> jsonList = json.decode(jsonStr);
      allQuotes.addAll(jsonList.map((json) => QuoteModel.fromJson(json)));
    }
    return allQuotes;
  }

  @override
  Future<Either<Failure, List<QuoteModel>>> getQuotes() async {
    try {
      List<QuoteModel> allQuotes = await _loadQuotesFromAssets();
      allQuotes = _syncWithLikedQuotes(allQuotes);

      allQuotes.shuffle();

      return Right(allQuotes);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure(message: 'Failed to load quotes: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> setOnboardingToCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = await prefs.setBool(SP.onboarding, true);
      if (result) {
        return Right(unit);
      } else {
        return Left(UnknownFailure());
      }
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isOnboardingComplete() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = prefs.getBool(SP.onboarding);
      return Right(result ?? false);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, int>> getLikeCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = prefs.getInt(SP.likeCount);
      return Right(result ?? 0);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, int>> incrementLikeCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final previousLikeCount = prefs.getInt(SP.likeCount) ?? 0;

      final result = await prefs.setInt(SP.likeCount, previousLikeCount + 1);
      if (result) {
        return Right(previousLikeCount + 1);
      } else {
        return Left(UnknownFailure());
      }
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, int>> decrementLikeCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final previousLikeCount = prefs.getInt(SP.likeCount) ?? 0;

      final result = await prefs.setInt(SP.likeCount, previousLikeCount - 1);
      if (result) {
        return Right(previousLikeCount - 1);
      } else {
        return Left(UnknownFailure());
      }
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isSwipeComplete() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = prefs.getBool(SP.swipe);
      return Right(result ?? false);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setSwipeToCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = await prefs.setBool(SP.swipe, true);
      if (result) {
        return Right(unit);
      } else {
        return Left(UnknownFailure());
      }
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isFeedSetupShown() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = prefs.getBool(SP.feedSetup);
      return Right(result ?? false);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isLikeGuideShown() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = prefs.getBool(SP.likeGuide);
      return Right(result ?? false);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isShareGuideShown() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = prefs.getBool(SP.shareGuide);
      return Right(result ?? false);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setFeedSetupShown() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = await prefs.setBool(SP.feedSetup, true);
      if (result) {
        return Right(unit);
      } else {
        return Left(UnknownFailure());
      }
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setLikeGuideShown() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = await prefs.setBool(SP.likeGuide, true);
      if (result) {
        return Right(unit);
      } else {
        return Left(UnknownFailure());
      }
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setShareGuideShown() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = await prefs.setBool(SP.shareGuide, true);
      if (result) {
        return Right(unit);
      } else {
        return Left(UnknownFailure());
      }
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveAllQuotesToAppGroup() async {
    try {
      final files = [
        'assets/data/jim_collins.json',
        'assets/data/napoleon_hill.json',
        'assets/data/peter_drucker.json',
      ];

      final List<QuoteModel> allQuotes = [];

      for (final file in files) {
        final jsonStr = await rootBundle.loadString(file);
        final List<dynamic> jsonList = json.decode(jsonStr);
        allQuotes.addAll(jsonList.map((json) => QuoteModel.fromJson(json)));
      }

      allQuotes.shuffle();

      await SharedPreferenceAppGroup.setAppGroup(Constants.widgetAppGroup);
      await SharedPreferenceAppGroup.setStringList(
        SP.quotesDataAppGroup,
        allQuotes.map((quote) => quote.quoteText).toList(),
      );

      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure(message: 'Failed to load quotes: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> saveOwnQuote(QuoteModel model) async {
    try {
      // final newModel = model.copyWith(isOwnQuote: true);
      final newModel = model.copyWith();
      final raw = prefs.getString(SP.ownQuotes);
      List<QuoteModel> ownQuotes = [];
      if (raw != null) {
        List<dynamic> list = jsonDecode(raw);
        ownQuotes = list.map((json) => QuoteModel.fromJson(json)).toList();
        ownQuotes.add(newModel);
      } else {
        ownQuotes = [newModel];
      }
      final isSuccessful = await prefs.setString(
        SP.ownQuotes,
        jsonEncode(ownQuotes.map((quote) => quote.toJson()).toList()),
      );
      if (isSuccessful) {
        return Right(unit);
      } else {
        return Left(UnknownFailure());
      }
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeOwnQuote(QuoteModel newModel) async {
    try {
      final raw = prefs.getString(SP.ownQuotes);
      if (raw == null) {
        return Right(null);
      }
      List<dynamic> list = jsonDecode(raw);
      List<QuoteModel> ownQuotes =
          list.map((json) => QuoteModel.fromJson(json)).toList();
      int prevLength = ownQuotes.length;
      ownQuotes.removeWhere((model) {
        return model.quoteText == newModel.quoteText;
      });
      if (ownQuotes.length != prevLength - 1) {
        debugPrint('the quote must be there to delete it');
        return Left(UnknownFailure());
      }
      await prefs.setString(
        SP.ownQuotes,
        jsonEncode(ownQuotes.map((model) => model.toJson()).toList()),
      );
      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Either<Failure, List<QuoteModel>?> getOwnQuote() {
    try {
      final ownQuotes = _getOwnQuotesList();
      if (ownQuotes == null) {
        return Right(null);
      }
      return Right(ownQuotes);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Either<Failure, int> getLikedQuotesCount() {
    try {
      final likedQuotes = _getLikedQuotesList();
      return Right(likedQuotes == null ? 0 : likedQuotes.length);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  List<QuoteModel>? _getLikedQuotesList() {
    final raw = prefs.getString(SP.likedQuotes);
    debugPrint(raw);
    if (raw == null) {
      return null;
    }
    List<dynamic> list = jsonDecode(raw);
    List<QuoteModel> likedQuotes =
        list.map((json) => QuoteModel.fromJson(json)).toList();
    return likedQuotes;
  }

  List<QuoteModel>? _getOwnQuotesList() {
    final raw = prefs.getString(SP.ownQuotes);
    debugPrint(raw);
    if (raw == null) {
      return null;
    }
    List<dynamic> list = jsonDecode(raw);
    List<QuoteModel> ownQuotes =
        list.map((json) => QuoteModel.fromJson(json)).toList();
    return ownQuotes;
  }

  @override
  Future<Either<Failure, List<QuoteModel>>> getRandomQuotes(int qty) async {
    List<QuoteModel> quotes = [];

    if (qty <= 0) {
      return Right(quotes);
    }

    quotes = [...(await _loadQuotesFromAssets())];

    quotes.shuffle();

    final result = quotes.sublist(quotes.length - qty);
    if (result.length != qty) {
      debugPrint('logic is wrong');
      return Left(UnknownFailure());
    }
    return Right(result);
  }
}
