import 'package:dartz/dartz.dart';

import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

class RemoveFavouriteFromCollectionUseCase {
  final CollectionsRepository repository;

  RemoveFavouriteFromCollectionUseCase(this.repository);

  Future<Either<Failure, void>> execute(
    int collectionId,
    int favouriteId,
  ) async {
    return repository.removeFavouriteQuoteFromCollection(
      collectionId,
      favouriteId,
    );
  }
}
