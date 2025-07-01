import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/collections/domain/repository/collections_repository.dart';
import 'package:sureline/features/search/domain/entity/search_entity.dart';

class GetSearchOfCollectionUseCase {
  final CollectionsRepository repository;

  GetSearchOfCollectionUseCase(this.repository);

  Future<Either<Failure, List<SearchEntity>>> execute(int collectionId) async {
    return repository.getSearchOfCollection(collectionId);
  }
}
