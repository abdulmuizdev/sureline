/// Retrieves collections containing a specific search quote.
///
/// Finds all collections that include a given searched quote.

import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/collection_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

/// Use case for fetching collections containing a search quote.
class GetCollectionsOfSearchUseCase {
  final CollectionsRepository repository;

  GetCollectionsOfSearchUseCase(this.repository);

  /// Executes the use case to retrieve collections.
  ///
  /// [searchId]: ID of the search quote to find collections for
  /// Returns: Either a failure or list of collection entities
  Future<Either<Failure, List<CollectionEntity>>> call(int searchId) async {
    return repository.getCollectionsOfSearch(searchId);
  }
}
