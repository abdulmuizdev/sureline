import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/common/domain/entities/recommendation_algorithm/quote_entity.dart';
import 'package:sureline/features/recommendation_algorithm/domain/repository/recommendation_algorithm_repository.dart';

class GetShownQuotesUseCase {
  final RecommendationAlgorithmRepository repository;

  GetShownQuotesUseCase(this.repository);

  Future<Either<Failure, List<QuoteEntity>>> call({required bool isPremium}) async {
    return repository.getShownQuotes(isPremium: isPremium);
  }
}
