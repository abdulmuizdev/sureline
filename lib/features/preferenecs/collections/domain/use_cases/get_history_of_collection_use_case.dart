import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';
import 'package:sureline/features/preferenecs/history/domain/entity/history_entity.dart';

class GetHistoryOfCollectionUseCase {
  final CollectionsRepository repository;

  GetHistoryOfCollectionUseCase(this.repository);

  Future<Either<Failure, List<HistoryEntity>>> execute(int collectionId) async {
    return repository.getHistoryOfCollection(collectionId);
  }
}
