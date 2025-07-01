import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/search/domain/entity/search_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SearchEntity>>> getSearch();
}
