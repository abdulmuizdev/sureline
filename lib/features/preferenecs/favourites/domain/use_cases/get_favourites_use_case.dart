import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/preferenecs/favourites/domain/repository/favourites_repository.dart';

class GetFavouritesUseCase {
  final FavouritesRepository repository;

  GetFavouritesUseCase(this.repository);

  Future<Either<Failure, List<FavouriteEntity>>> call() async {
    return repository.getFavourites();
  }
}
