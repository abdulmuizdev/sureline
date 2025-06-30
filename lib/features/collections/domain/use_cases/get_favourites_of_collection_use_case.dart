import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/collections/domain/repository/collections_repository.dart';
import 'package:sureline/features/favourites/domain/entity/favourite_entity.dart';

class GetFavouritesOfCollectionUseCase {
  final CollectionsRepository repository;

  GetFavouritesOfCollectionUseCase(this.repository);

  Future<Either<Failure, List<FavouriteEntity>>> execute(
    int collectionId,
  ) async {
    return repository.getFavouritesOfCollection(collectionId);
  }
}
