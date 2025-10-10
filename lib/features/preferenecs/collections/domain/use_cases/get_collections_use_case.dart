/// Retrieves all user collections.
///
/// Fetches collections with their associated quotes.
/// This use case orchestrates the retrieval of all user collections,
/// including their relationships with different types of quotes
/// (favourites, own quotes, history, search). It serves as the primary
/// entry point for displaying collections in the UI.

import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/collection_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

/// Use case for fetching all user collections.
///
/// This use case encapsulates the business logic for retrieving collections.
/// It handles the orchestration of data retrieval and ensures that collections
/// are returned with their complete quote relationships populated.
///
/// Usage context:
/// - Displaying collections list in the main collections page
/// - Refreshing collections after CRUD operations
/// - Initializing collections data for other features
class GetCollectionsUseCase {
  /// Repository dependency for collections data access.
  final CollectionsRepository repository;

  /// Creates a new instance with the required repository.
  GetCollectionsUseCase(this.repository);

  /// Executes the use case to retrieve collections.
  ///
  /// Fetches all user collections with their associated quotes from all
  /// quote types (favourites, own quotes, history, search). Each collection
  /// is populated with its complete quote relationships.
  ///
  /// Returns: Either a failure or list of collections with populated quote data
  Future<Either<Failure, List<CollectionEntity>>> execute() async {
    return repository.getCollections();
  }
}
