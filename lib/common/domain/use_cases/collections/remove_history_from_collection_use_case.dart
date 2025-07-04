import 'package:dartz/dartz.dart';

import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

class RemoveHistoryFromCollectionUseCase {
  final CollectionsRepository repository;

  RemoveHistoryFromCollectionUseCase(this.repository);

  Future<Either<Failure, void>> execute(int collectionId, int quoteId) async {
    return repository.removeHistoryFromCollection(collectionId, quoteId);
  }
}
