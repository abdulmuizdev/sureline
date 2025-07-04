import 'package:dartz/dartz.dart';

import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

class RemoveSearchFromCollectionUseCase {
  final CollectionsRepository repository;

  RemoveSearchFromCollectionUseCase(this.repository);

  Future<Either<Failure, void>> execute(int collectionId, int searchId) async {
    return repository.removeSearchFromCollection(collectionId, searchId);
  }
}
