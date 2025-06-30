import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/favourites/domain/repository/favourites_repository.dart';

class GetFavouritesCountUseCase {
  final FavouritesRepository repository;

  GetFavouritesCountUseCase(this.repository);

  Future<Either<Failure, int>> call() async {
    return repository.getFavouritesCount();
  }
}
