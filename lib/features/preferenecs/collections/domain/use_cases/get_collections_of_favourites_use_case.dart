/// Retrieves collections containing a specific favourite.
///
/// Finds all collections that include a given favourite quote.

import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/collection_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

/// Use case for fetching collections containing a favourite.
class GetCollectionsOfFavouritesUseCase {
  final CollectionsRepository repository;

  GetCollectionsOfFavouritesUseCase(this.repository);

  /// Executes the use case to retrieve collections.
  ///
  /// [favouriteId]: ID of the favourite to find collections for
  /// Returns: Either a failure or list of collection entities
  Future<Either<Failure, List<CollectionEntity>>> call(int favouriteId) async {
    return repository.getCollectionsOfFavourite(favouriteId);
  }
}
