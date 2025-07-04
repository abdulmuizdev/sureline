import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/data/model/collection_model.dart';
import 'package:sureline/features/preferenecs/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

class RemoveCollectionUseCase {
  final CollectionsRepository repository;

  RemoveCollectionUseCase(this.repository);

  Future<Either<Failure, void>> execute(CollectionEntity entity) async {
    return repository.removeCollection(CollectionModel.fromEntity(entity));
  }
}
