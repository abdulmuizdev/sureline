import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/collections/data/model/collection_model.dart';
import 'package:sureline/features/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/collections/domain/repository/collections_repository.dart';

class SaveCollectionUseCase {
  final CollectionsRepository repository;

  SaveCollectionUseCase(this.repository);

  Future<Either<Failure, void>> execute(CollectionEntity entity) async {
    return repository.saveCollection(CollectionModel.fromEntity(entity));
  }
}
