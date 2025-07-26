import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/favourites/domain/repository/favourites_repository.dart';

class RemoveFavouriteUseCase {
  final FavouritesRepository repository;

  RemoveFavouriteUseCase(this.repository);

  Future<Either<Failure, void>> call({
    int? quoteId,
    int? ownQuoteId,
    int? historyId,
    int? searchId,
  }) async {
    return repository.removeFavourite(
      quoteId: quoteId,
      ownQuoteId: ownQuoteId,
      historyId: historyId,
      searchId: searchId,
    );
  }
}
