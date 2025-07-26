/// Retrieves favourites within a specific collection.
///
/// Fetches all favourite quotes for a given collection ID.

import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/favourite_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

/// Use case for fetching favourites of a collection.
class GetFavouritesOfCollectionUseCase {
  final CollectionsRepository repository;

  GetFavouritesOfCollectionUseCase(this.repository);

  /// Executes the use case to retrieve favourites.
  ///
  /// [collectionId]: ID of the collection to fetch favourites from
  /// Returns: Either a failure or list of favourite entities
  Future<Either<Failure, List<FavouriteEntity>>> execute(int collectionId) async {
    return repository.getFavouritesOfCollection(collectionId);
  }
}
