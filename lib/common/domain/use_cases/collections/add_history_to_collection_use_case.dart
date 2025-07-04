import 'package:dartz/dartz.dart';

import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

class AddHistoryToCollectionUseCase {
  final CollectionsRepository repository;

  AddHistoryToCollectionUseCase(this.repository);

  Future<Either<Failure, void>> execute(int collectionId, int quoteId) async {
    return repository.addHistoryToCollection(collectionId, quoteId);
  }
}
