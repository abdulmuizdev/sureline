/// Saves a new collection to storage.
///
/// Persists collection data with associated quotes.
/// This use case handles the creation of new collections, ensuring
/// proper data validation and persistence. It converts domain entities
/// to data models for storage and manages the collection lifecycle.

import 'package:dartz/dartz.dart';
import 'package:sureline/common/data/model/collections/collection_model.dart';
import 'package:sureline/common/domain/entities/collections/collection_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

/// Use case for saving a collection.
///
/// This use case encapsulates the business logic for creating new collections.
/// It handles the conversion from domain entities to data models and ensures
/// proper persistence of collection data. The use case maintains separation
/// between domain and data layers.
///
/// Usage context:
/// - Creating new collections from the UI
/// - Programmatic collection creation
/// - Collection import/export functionality
class SaveCollectionUseCase {
  /// Repository dependency for collections data access.
  final CollectionsRepository repository;

  /// Creates a new instance with the required repository.
  SaveCollectionUseCase(this.repository);

  /// Executes the use case to save a collection.
  ///
  /// Converts the domain entity to a data model and persists it to storage.
  /// The collection is immediately available for adding quotes and will appear
  /// in the collections list.
  ///
  /// [entity]: The collection entity to save with name and metadata
  /// Returns: Either a failure or void on success
  Future<Either<Failure, void>> execute(CollectionEntity entity) async {
    return repository.saveCollection(CollectionModel.fromEntity(entity));
  }
}
