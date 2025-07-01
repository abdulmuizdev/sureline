import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/collections/domain/repository/collections_repository.dart';

class GetCollectionsOfHistoryUseCase {
  final CollectionsRepository repository;

  GetCollectionsOfHistoryUseCase(this.repository);

  Future<Either<Failure, List<CollectionEntity>>> call(int historyId) {
    return repository.getCollectionsOfHistory(historyId);
  }
}
