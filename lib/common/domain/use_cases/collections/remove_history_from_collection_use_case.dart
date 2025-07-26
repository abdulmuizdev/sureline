import 'package:dartz/dartz.dart';

import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

/// Use case for removing a history item from a collection.
///
/// This use case handles the business logic for removing a history item
/// from a specific collection in the user's preferences.
class RemoveHistoryFromCollectionUseCase {
  /// The collections repository dependency.
  final CollectionsRepository repository;

  /// Creates an instance of [RemoveHistoryFromCollectionUseCase].
  const RemoveHistoryFromCollectionUseCase(this.repository);

  /// Executes the use case to remove a history item from a collection.
  ///
  /// Returns [Either<Failure, void>] indicating success or failure.
  Future<Either<Failure, void>> execute(int collectionId, int historyId) async {
    return repository.removeHistoryFromCollection(collectionId, historyId);
  }
}
