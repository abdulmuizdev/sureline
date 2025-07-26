/// Removes a collection from storage.
///
/// Deletes collection and its associated data.

import 'package:dartz/dartz.dart';
import 'package:sureline/common/data/model/collections/collection_model.dart';
import 'package:sureline/common/domain/entities/collections/collection_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

/// Use case for removing a collection.
class RemoveCollectionUseCase {
  final CollectionsRepository repository;

  RemoveCollectionUseCase(this.repository);

  /// Executes the use case to remove a collection.
  ///
  /// [entity]: The collection entity to remove
  /// Returns: Either a failure or void on success
  Future<Either<Failure, void>> execute(CollectionEntity entity) async {
    return repository.removeCollection(CollectionModel.fromEntity(entity));
  }
}
