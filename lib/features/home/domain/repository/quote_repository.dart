import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/entity/quote_entity.dart';

abstract class QuoteRepository {
  Future<Either<Failure, void>> saveAllQuotesToAppGroup();

  Future<Either<Failure, List<QuoteEntity>>> getQuotes();

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

  Future<Either<Failure, void>> saveLikedQuote(QuoteEntity entity);
  Future<Either<Failure, void>> saveOwnQuote(QuoteEntity entity);

  Future<Either<Failure, void>> removeLikedQuote(QuoteEntity newEntity);
  Future<Either<Failure, void>> removeOwnQuote(QuoteEntity newEntity);

  Either<Failure, List<QuoteEntity>?> getLikedQuote();
  Either<Failure, List<QuoteEntity>?> getOwnQuote();

  Either<Failure, int> getLikedQuotesCount();

  Future<Either<Failure, List<QuoteEntity>>> getRandomQuotes(int qty);

  Future<Either<Failure, List<QuoteEntity>>> getQuotesSearchResults(
    String query,
    int page,
  );
}
