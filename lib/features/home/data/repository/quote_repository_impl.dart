/// Implementation of quote repository for home feature.
///
/// Handles quote operations, user preferences, and guide states.

import 'package:dartz/dartz.dart';
import 'package:sureline/common/data/model/quote_model.dart';
import 'package:sureline/common/domain/entities/recommendation_algorithm/quote_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/data/data_source/quote_data_source.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

/// Implementation of the quote repository.
class QuoteRepositoryImpl extends QuoteRepository {
  /// Creates a new QuoteRepositoryImpl instance.
  QuoteRepositoryImpl(this.quoteDataSource);

  /// Data source for quote operations.
  final QuoteDataSource quoteDataSource;

  @override
  Future<Either<Failure, List<QuoteEntity>>> getQuotes({required bool isPremium}) {
    return quoteDataSource.getQuotes(isPremium: isPremium);
  }

  @override
  Future<Either<Failure, bool>> isOnboardingComplete() {
    return quoteDataSource.isOnboardingComplete();
  }

  @override
  Future<Either<Failure, void>> setOnboardingToCompleted() {
    return quoteDataSource.setOnboardingToCompleted();
  }

  @override
  Future<Either<Failure, bool>> isSwipeComplete() {
    return quoteDataSource.isSwipeComplete();
  }

  @override
  Future<Either<Failure, void>> setSwipeToCompleted() {
    return quoteDataSource.setSwipeToCompleted();
  }

  @override
  Future<Either<Failure, int>> getLikeCount() {
    return quoteDataSource.getLikeCount();
  }

  @override
  Future<Either<Failure, int>> incrementLikeCount() {
    return quoteDataSource.incrementLikeCount();
  }

  @override
  Future<Either<Failure, int>> decrementLikeCount() {
    return quoteDataSource.decrementLikeCount();
  }

  @override
  Future<Either<Failure, bool>> isFeedSetupShown() {
    return quoteDataSource.isFeedSetupShown();
  }

  @override
  Future<Either<Failure, bool>> isLikeGuideShown() {
    return quoteDataSource.isLikeGuideShown();
  }

  @override
  Future<Either<Failure, bool>> isShareGuideShown() {
    return quoteDataSource.isShareGuideShown();
  }

  @override
  Future<Either<Failure, void>> setFeedSetupShown() {
    return quoteDataSource.setFeedSetupShown();
  }

  @override
  Future<Either<Failure, void>> setLikeGuideShown() {
    return quoteDataSource.setLikeGuideShown();
  }

  @override
  Future<Either<Failure, void>> setShareGuideShown() {
    return quoteDataSource.setShareGuideShown();
  }

  @override
  Future<Either<Failure, void>> saveAllQuotesToAppGroup({required bool isPremium}) {
    return quoteDataSource.saveAllQuotesToAppGroup(isPremium: isPremium);
  }

  @override
  Either<Failure, List<QuoteEntity>?> getOwnQuote() {
    return quoteDataSource.getOwnQuote();
  }

  @override
  Either<Failure, int> getLikedQuotesCount() {
    return quoteDataSource.getLikedQuotesCount();
  }

  @override
  Future<Either<Failure, List<QuoteEntity>>> getQuotesSearchResults(String query, int page) {
    return quoteDataSource.getQuotesSearchResults(query, page);
  }

  @override
  Future<Either<Failure, List<QuoteEntity>>> getRandomQuotes(int qty, {required bool isPremium}) {
    return quoteDataSource.getRandomQuotes(qty, isPremium: isPremium);
  }

  @override
  Future<Either<Failure, void>> removeOwnQuote(QuoteEntity newEntity) {
    return quoteDataSource.removeOwnQuote(QuoteModel.fromEntity(newEntity));
  }

  @override
  Future<Either<Failure, void>> saveOwnQuote(QuoteEntity entity) {
    return quoteDataSource.saveOwnQuote(QuoteModel.fromEntity(entity));
  }
}
