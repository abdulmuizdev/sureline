/// Repository interface for home feature operations.
///
/// Defines operations for quotes, onboarding, guides, and user preferences.

import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/recommendation_algorithm/quote_entity.dart';
import 'package:sureline/core/error/failures.dart';

/// Abstract repository for quote operations.
abstract class QuoteRepository {
  /// Saves all quotes to app group for widget access.
  Future<Either<Failure, void>> saveAllQuotesToAppGroup({required bool isPremium});

  /// Gets all quotes.
  Future<Either<Failure, List<QuoteEntity>>> getQuotes({required bool isPremium});

  /// Sets onboarding to completed.
  Future<Either<Failure, void>> setOnboardingToCompleted();

  /// Checks if onboarding is complete.
  Future<Either<Failure, bool>> isOnboardingComplete();

  /// Sets swipe to completed.
  Future<Either<Failure, void>> setSwipeToCompleted();

  /// Checks if swipe is complete.
  Future<Either<Failure, bool>> isSwipeComplete();

  /// Increments the like count.
  Future<Either<Failure, int>> incrementLikeCount();

  /// Decrements the like count.
  Future<Either<Failure, int>> decrementLikeCount();

  /// Gets the current like count.
  Future<Either<Failure, int>> getLikeCount();

  /// Checks if like guide is shown.
  Future<Either<Failure, bool>> isLikeGuideShown();

  /// Sets like guide to shown.
  Future<Either<Failure, void>> setLikeGuideShown();

  /// Checks if share guide is shown.
  Future<Either<Failure, bool>> isShareGuideShown();

  /// Sets share guide to shown.
  Future<Either<Failure, void>> setShareGuideShown();

  /// Checks if feed setup is shown.
  Future<Either<Failure, bool>> isFeedSetupShown();

  /// Sets feed setup to shown.
  Future<Either<Failure, void>> setFeedSetupShown();

  /// Saves an own quote.
  Future<Either<Failure, void>> saveOwnQuote(QuoteEntity entity);

  /// Removes an own quote.
  Future<Either<Failure, void>> removeOwnQuote(QuoteEntity newEntity);

  /// Gets own quotes.
  Either<Failure, List<QuoteEntity>?> getOwnQuote();

  /// Gets the count of liked quotes.
  Either<Failure, int> getLikedQuotesCount();

  /// Gets random quotes.
  Future<Either<Failure, List<QuoteEntity>>> getRandomQuotes(int qty, {required bool isPremium});

  /// Gets quotes search results.
  Future<Either<Failure, List<QuoteEntity>>> getQuotesSearchResults(String query, int page);
}
