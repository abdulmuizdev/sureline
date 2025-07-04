import 'package:dartz/dartz.dart';

import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

class AddOwnQuoteToCollectionUseCase {
  final CollectionsRepository repository;

  AddOwnQuoteToCollectionUseCase(this.repository);

  Future<Either<Failure, void>> execute(
    int collectionId,
    int ownQuoteId,
  ) async {
    return repository.addOwnQuoteToCollection(collectionId, ownQuoteId);
  }
}
