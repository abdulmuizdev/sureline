import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';

class GetCollectionsOfSearchUseCase {
  final CollectionsRepository repository;

  GetCollectionsOfSearchUseCase(this.repository);

  Future<Either<Failure, List<CollectionEntity>>> call(int searchId) {
    return repository.getCollectionsOfSearch(searchId);
  }
}
