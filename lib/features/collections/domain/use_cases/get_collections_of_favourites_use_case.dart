import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/collections/domain/repository/collections_repository.dart';

class GetCollectionsOfFavouritesUseCase {
  final CollectionsRepository repository;

  GetCollectionsOfFavouritesUseCase(this.repository);

  Future<Either<Failure, List<CollectionEntity>>> call(int favouriteId) {
    return repository.getCollectionsOfFavourite(favouriteId);
  }
}
