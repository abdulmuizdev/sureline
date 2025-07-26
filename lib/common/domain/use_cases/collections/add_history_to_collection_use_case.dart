import 'package:dartz/dartz.dart';

import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

/// Use case for adding a history item to a collection.
///
/// This use case handles the business logic for adding a history item
/// to a specific collection in the user's preferences.
class AddHistoryToCollectionUseCase {
  /// The collections repository dependency.
  final CollectionsRepository repository;

  /// Creates an instance of [AddHistoryToCollectionUseCase].
  const AddHistoryToCollectionUseCase(this.repository);

  /// Executes the use case to add a history item to a collection.
  ///
  /// Returns [Either<Failure, void>] indicating success or failure.
  Future<Either<Failure, void>> execute(int collectionId, int historyId) async {
    return repository.addHistoryToCollection(collectionId, historyId);
  }
}
