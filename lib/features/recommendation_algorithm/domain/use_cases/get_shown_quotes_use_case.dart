import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';
import 'package:sureline/features/recommendation_algorithm/domain/repository/recommendation_algorithm_repository.dart';

class GetShownQuotesUseCase {
  final RecommendationAlgorithmRepository repository;

  GetShownQuotesUseCase(this.repository);

  Future<Either<Failure, List<QuoteEntity>>> call() async {
    return repository.getShownQuotes();
  }
}
