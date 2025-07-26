/// Retrieves search quotes within a specific collection.
///
/// Fetches searched quotes for a given collection ID.

import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/search_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

/// Use case for fetching search quotes of a collection.
class GetSearchOfCollectionUseCase {
  final CollectionsRepository repository;

  GetSearchOfCollectionUseCase(this.repository);

  /// Executes the use case to retrieve search quotes.
  ///
  /// [collectionId]: ID of the collection to fetch search quotes from
  /// [isPremium]: Whether the user has premium access
  /// Returns: Either a failure or list of search entities
  Future<Either<Failure, List<SearchEntity>>> execute(
    int collectionId, {
    required bool isPremium,
  }) async {
    return repository.getSearchOfCollection(collectionId, isPremium: isPremium);
  }
}
