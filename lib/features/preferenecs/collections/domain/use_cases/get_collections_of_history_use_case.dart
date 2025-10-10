/// Retrieves collections containing a specific history quote.
///
/// Finds all collections that include a given viewed quote.

import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/collection_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

/// Use case for fetching collections containing a history quote.
class GetCollectionsOfHistoryUseCase {
  final CollectionsRepository repository;

  GetCollectionsOfHistoryUseCase(this.repository);

  /// Executes the use case to retrieve collections.
  ///
  /// [quoteId]: ID of the history quote to find collections for
  /// Returns: Either a failure or list of collection entities
  Future<Either<Failure, List<CollectionEntity>>> call(int quoteId) async {
    return repository.getCollectionsOfHistory(quoteId);
  }
}
