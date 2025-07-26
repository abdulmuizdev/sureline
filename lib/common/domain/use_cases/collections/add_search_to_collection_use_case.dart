import 'package:dartz/dartz.dart';

import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

/// Use case for adding a search to a collection.
///
/// This use case handles the business logic for adding a search item
/// to a specific collection in the user's preferences.
class AddSearchToCollectionUseCase {
  /// The collections repository dependency.
  final CollectionsRepository repository;

  /// Creates an instance of [AddSearchToCollectionUseCase].
  const AddSearchToCollectionUseCase(this.repository);

  /// Executes the use case to add a search to a collection.
  ///
  /// Returns [Either<Failure, void>] indicating success or failure.
  Future<Either<Failure, void>> execute(int collectionId, int searchId) async {
    return repository.addSearchToCollection(collectionId, searchId);
  }
}
