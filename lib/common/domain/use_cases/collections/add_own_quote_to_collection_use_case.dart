import 'package:dartz/dartz.dart';

import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

/// Use case for adding an own quote to a collection.
///
/// This use case handles the business logic for adding a user's own quote
/// to a specific collection in the user's preferences.
class AddOwnQuoteToCollectionUseCase {
  /// The collections repository dependency.
  final CollectionsRepository repository;

  /// Creates an instance of [AddOwnQuoteToCollectionUseCase].
  const AddOwnQuoteToCollectionUseCase(this.repository);

  /// Executes the use case to add an own quote to a collection.
  ///
  /// Returns [Either<Failure, void>] indicating success or failure.
  Future<Either<Failure, void>> execute(int collectionId, int ownQuoteId) async {
    return repository.addOwnQuoteToCollection(collectionId, ownQuoteId);
  }
}
