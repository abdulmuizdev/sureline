import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/favourites/domain/repository/favourites_repository.dart';

class RemoveFavouriteUseCase {
  final FavouritesRepository repository;

  RemoveFavouriteUseCase(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return repository.removeFavourite(id);
  }
}
