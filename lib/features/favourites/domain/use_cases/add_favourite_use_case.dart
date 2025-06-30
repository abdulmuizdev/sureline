import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/favourites/domain/repository/favourites_repository.dart';
import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';

class AddFavouriteUseCase {
  final FavouritesRepository repository;

  AddFavouriteUseCase(this.repository);

  Future<Either<Failure, void>> call(QuoteEntity quote) async {
    return repository.addFavourite(quote);
  }
}
