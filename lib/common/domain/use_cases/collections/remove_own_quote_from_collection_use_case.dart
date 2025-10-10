import 'package:dartz/dartz.dart';

import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

/// Use case for removing an own quote from a collection.
///
/// This use case handles the business logic for removing a user's own quote
/// from a specific collection in the user's preferences.
class RemoveOwnQuoteFromCollectionUseCase {
  /// The collections repository dependency.
  final CollectionsRepository repository;

  /// Creates an instance of [RemoveOwnQuoteFromCollectionUseCase].
  const RemoveOwnQuoteFromCollectionUseCase(this.repository);

  /// Executes the use case to remove an own quote from a collection.
  ///
  /// Returns [Either<Failure, void>] indicating success or failure.
  Future<Either<Failure, void>> execute(int collectionId, int ownQuoteId) async {
    return repository.removeOwnQuoteFromCollection(collectionId, ownQuoteId);
  }
}
