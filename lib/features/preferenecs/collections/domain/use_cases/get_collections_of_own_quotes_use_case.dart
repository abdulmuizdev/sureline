/// Retrieves collections containing a specific own quote.
///
/// Finds all collections that include a given user-created quote.

import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/collection_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

/// Use case for fetching collections containing an own quote.
class GetCollectionsOfOwnQuotesUseCase {
  final CollectionsRepository repository;

  GetCollectionsOfOwnQuotesUseCase(this.repository);

  /// Executes the use case to retrieve collections.
  ///
  /// [ownQuoteId]: ID of the own quote to find collections for
  /// Returns: Either a failure or list of collection entities
  Future<Either<Failure, List<CollectionEntity>>> call(int ownQuoteId) async {
    return repository.getCollectionsOfOwnQuote(ownQuoteId);
  }
}
