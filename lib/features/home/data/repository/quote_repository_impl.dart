import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/data/model/collection_model.dart';
import 'package:sureline/features/preferenecs/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/home/data/data_source/quote_data_source.dart';
import 'package:sureline/features/recommendation_algorithm/data/model/quote_model.dart';
import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

class QuoteRepositoryImpl extends QuoteRepository {
  final QuoteDataSource quoteDataSource;

  QuoteRepositoryImpl(this.quoteDataSource);

  @override
  Future<Either<Failure, List<QuoteEntity>>> getQuotes() {
    return quoteDataSource.getQuotes();
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
  Future<Either<Failure, void>> saveAllQuotesToAppGroup() {
    return quoteDataSource.saveAllQuotesToAppGroup();
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
  Future<Either<Failure, List<QuoteEntity>>> getQuotesSearchResults(
    String query,
    int page,
  ) {
    return quoteDataSource.getQuotesSearchResults(query, page);
  }

  @override
  Future<Either<Failure, List<QuoteEntity>>> getRandomQuotes(int qty) {
    return quoteDataSource.getRandomQuotes(qty);
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
