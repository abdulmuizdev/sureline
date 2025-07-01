import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/recommendation_algorithm/data/data_source/recommendation_algorithm_data_source.dart';
import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';
import 'package:sureline/features/recommendation_algorithm/domain/repository/recommendation_algorithm_repository.dart';

class RecommendationAlgorithmRepositoryImpl
    extends RecommendationAlgorithmRepository {
  final RecommendationAlgorithmDataSource dataSource;

  RecommendationAlgorithmRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, void>> initialize() async {
    return dataSource.initialize();
  }

  @override
  Future<Either<Failure, List<QuoteEntity>>> getQuotes(int page) async {
    return dataSource.getQuotes(page);
  }

  @override
  Future<Either<Failure, void>> markQuoteAsShown(int id) async {
    return dataSource.markQuoteAsShown(id);
  }

  @override
  Future<Either<Failure, List<QuoteEntity>>> getShownQuotes() async {
    return dataSource.getShownQuotes();
  }
}
