import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/search/data/data_source/search_data_source.dart';
import 'package:sureline/features/preferenecs/search/domain/entity/search_entity.dart';
import 'package:sureline/features/preferenecs/search/domain/repository/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource dataSource;

  SearchRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<SearchEntity>>> getSearch() async {
    return await dataSource.getSearch();
  }
}
