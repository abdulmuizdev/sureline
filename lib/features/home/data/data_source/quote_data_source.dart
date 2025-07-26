/// Data source interface for quote operations.
///
/// Defines methods for quote management and user preferences.

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preference_app_group/shared_preference_app_group.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/common/data/model/quote_model.dart';
import 'package:sureline/core/constants/constants.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/error/failures.dart';

/// Abstract data source for quote operations.
abstract class QuoteDataSource {
  /// Saves all quotes to app group for widget access.
  Future<Either<Failure, void>> saveAllQuotesToAppGroup({required bool isPremium});

  /// Loads all quotes from assets and synchronizes with user preferences.
  Future<Either<Failure, List<QuoteModel>>> getQuotes({required bool isPremium});

  /// Marks onboarding as completed in user preferences.
  Future<Either<Failure, void>> setOnboardingToCompleted();

  /// Checks if onboarding has been completed.
  Future<Either<Failure, bool>> isOnboardingComplete();

  /// Marks swipe tutorial as completed.
  Future<Either<Failure, void>> setSwipeToCompleted();

  /// Checks if swipe tutorial has been completed.
  Future<Either<Failure, bool>> isSwipeComplete();

  /// Increments the like count by 1.
  Future<Either<Failure, int>> incrementLikeCount();

  /// Decrements the like count by 1.
  Future<Either<Failure, int>> decrementLikeCount();

  /// Gets the current like count from preferences.
  Future<Either<Failure, int>> getLikeCount();

  /// Checks if like guide has been shown.
  Future<Either<Failure, bool>> isLikeGuideShown();

  /// Marks like guide as shown.
  Future<Either<Failure, void>> setLikeGuideShown();

  /// Checks if share guide has been shown.
  Future<Either<Failure, bool>> isShareGuideShown();

  /// Marks share guide as shown.
  Future<Either<Failure, void>> setShareGuideShown();

  /// Checks if feed setup has been shown.
  Future<Either<Failure, bool>> isFeedSetupShown();

  /// Marks feed setup as shown.
  Future<Either<Failure, void>> setFeedSetupShown();

  /// Saves a quote to the user's own quotes list.
  Future<Either<Failure, void>> saveOwnQuote(QuoteModel model);

  /// Removes a quote from the user's own quotes list.
  Future<Either<Failure, void>> removeOwnQuote(QuoteModel newModel);

  /// Gets the user's own quotes.
  Either<Failure, List<QuoteModel>?> getOwnQuote();

  /// Gets the count of liked quotes.
  Either<Failure, int> getLikedQuotesCount();

  /// Gets a random selection of quotes.
  Future<Either<Failure, List<QuoteModel>>> getRandomQuotes(int qty, {required bool isPremium});

  /// Gets quotes search results.
  Future<Either<Failure, List<QuoteModel>>> getQuotesSearchResults(String query, int page);
}

/// Implementation of quote data source using SharedPreferences.
class QuoteDataSourceImpl extends QuoteDataSource {
  final SharedPreferences prefs;

  QuoteDataSourceImpl(this.prefs);

  @override
  Future<Either<Failure, List<QuoteModel>>> getQuotesSearchResults(String query, int page) async {
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
                  (model) =>
                      model.quoteText.trim().toLowerCase().contains(query.trim().toLowerCase()),
                )
                .toList();
      }

      return Right(searchedQuotes);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  /// Synchronizes quotes with liked quotes data.
  ///
  /// Updates quote states based on user's liked quotes.
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

  /// Loads quotes from asset files.
  ///
  /// Reads JSON files and converts to QuoteModel objects.
  Future<List<QuoteModel>> _loadQuotesFromAssets() async {
    final files = [
      'assets/data/jim_collins.json',
      'assets/data/napoleon_hill.json',
      'assets/data/peter_drucker.json',
    ];

    final List<QuoteModel> allQuotes = [];

    for (final file in files) {
      final jsonStr = await rootBundle.loadString(file);
      final List<dynamic> jsonList = json.decode(jsonStr) as List<dynamic>;
      allQuotes.addAll(jsonList.map((json) => QuoteModel.fromJson(json as Map<String, dynamic>)));
    }
    return allQuotes;
  }

  @override
  Future<Either<Failure, List<QuoteModel>>> getQuotes({required bool isPremium}) async {
    try {
      List<QuoteModel> allQuotes = await _loadQuotesFromAssets();

      // Filter out premium quotes if user is not premium
      if (!isPremium) {
        allQuotes = allQuotes.where((quote) => !quote.isPremium).toList();
      }

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
  Future<Either<Failure, void>> saveAllQuotesToAppGroup({required bool isPremium}) async {
    try {
      final files = [
        'assets/data/jim_collins.json',
        'assets/data/napoleon_hill.json',
        'assets/data/peter_drucker.json',
      ];

      final List<QuoteModel> allQuotes = [];

      for (final file in files) {
        final jsonStr = await rootBundle.loadString(file);
        final List<dynamic> jsonList = json.decode(jsonStr) as List<dynamic>;
        allQuotes.addAll(jsonList.map((json) => QuoteModel.fromJson(json as Map<String, dynamic>)));
      }

      // Filter out premium quotes if user is not premium
      if (!isPremium) {
        allQuotes.removeWhere((quote) => quote.isPremium);
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
        final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
        ownQuotes = list.map((json) => QuoteModel.fromJson(json as Map<String, dynamic>)).toList();
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
      debugPrint('$e');
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
      final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
      List<QuoteModel> ownQuotes =
          list.map((json) => QuoteModel.fromJson(json as Map<String, dynamic>)).toList();
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
      debugPrint('$e');
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
      debugPrint('$e');
      return Left(UnknownFailure());
    }
  }

  @override
  Either<Failure, int> getLikedQuotesCount() {
    try {
      final likedQuotes = _getLikedQuotesList();
      return Right(likedQuotes == null ? 0 : likedQuotes.length);
    } catch (e) {
      debugPrint('$e');
      return Left(UnknownFailure());
    }
  }

  /// Gets the list of liked quotes from preferences.
  List<QuoteModel>? _getLikedQuotesList() {
    final raw = prefs.getString(SP.likedQuotes);
    debugPrint(raw);
    if (raw == null) {
      return null;
    }
    final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
    List<QuoteModel> likedQuotes =
        list.map((json) => QuoteModel.fromJson(json as Map<String, dynamic>)).toList();
    return likedQuotes;
  }

  /// Gets the list of own quotes from preferences.
  List<QuoteModel>? _getOwnQuotesList() {
    final raw = prefs.getString(SP.ownQuotes);
    debugPrint(raw);
    if (raw == null) {
      return null;
    }
    final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
    List<QuoteModel> ownQuotes =
        list.map((json) => QuoteModel.fromJson(json as Map<String, dynamic>)).toList();
    return ownQuotes;
  }

  @override
  Future<Either<Failure, List<QuoteModel>>> getRandomQuotes(
    int qty, {
    required bool isPremium,
  }) async {
    List<QuoteModel> quotes = [];

    if (qty <= 0) {
      return Right(quotes);
    }

    quotes = [...(await _loadQuotesFromAssets())];

    // Filter out premium quotes if user is not premium
    if (!isPremium) {
      quotes = quotes.where((quote) => !quote.isPremium).toList();
    }

    quotes.shuffle();

    final result = quotes.sublist(quotes.length - qty);
    if (result.length != qty) {
      debugPrint('logic is wrong');
      return Left(UnknownFailure());
    }
    return Right(result);
  }
}
