import 'package:sureline/features/preferenecs/search/domain/repository/search_repository.dart';
import 'package:sureline/features/preferenecs/search/domain/entity/search_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';

class GetSearchUseCase {
  final SearchRepository repository;

  GetSearchUseCase(this.repository);

  Future<Either<Failure, List<SearchEntity>>> call() async {
    return await repository.getSearch();
  }
}
