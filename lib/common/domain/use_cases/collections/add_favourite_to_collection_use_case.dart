import 'package:dartz/dartz.dart';

import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/collections/domain/repository/collections_repository.dart';

class AddFavouriteToCollectionUseCase {
  final CollectionsRepository repository;

  AddFavouriteToCollectionUseCase(this.repository);

  Future<Either<Failure, void>> execute(
    int collectionId,
    int favouriteId,
  ) async {
    return repository.addQuoteToCollection(collectionId, favouriteId);
  }
}
