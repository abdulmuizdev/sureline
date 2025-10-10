/// Retrieves own quotes within a specific collection.
///
/// Fetches user-created quotes for a given collection ID.

import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/own_quote_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

/// Use case for fetching own quotes of a collection.
class GetOwnQuotesOfCollectionUseCase {
  final CollectionsRepository repository;

  GetOwnQuotesOfCollectionUseCase(this.repository);

  /// Executes the use case to retrieve own quotes.
  ///
  /// [collectionId]: ID of the collection to fetch own quotes from
  /// Returns: Either a failure or list of own quote entities
  Future<Either<Failure, List<OwnQuoteEntity>>> execute(int collectionId) async {
    return repository.getOwnQuotesOfCollection(collectionId);
  }
}
