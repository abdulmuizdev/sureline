import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/recommendation_algorithm/domain/repository/recommendation_algorithm_repository.dart';

class MarkQuoteAsShownUseCase {
  final RecommendationAlgorithmRepository repository;

  MarkQuoteAsShownUseCase(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return repository.markQuoteAsShown(id);
  }
}
