/// Retrieves history quotes within a specific collection.
///
/// Fetches viewed quotes for a given collection ID.

import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/history_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

/// Use case for fetching history quotes of a collection.
class GetHistoryOfCollectionUseCase {
  final CollectionsRepository repository;

  GetHistoryOfCollectionUseCase(this.repository);

  /// Executes the use case to retrieve history quotes.
  ///
  /// [collectionId]: ID of the collection to fetch history from
  /// Returns: Either a failure or list of history entities
  Future<Either<Failure, List<HistoryEntity>>> execute(int collectionId) async {
    return repository.getHistoryOfCollection(collectionId);
  }
}
