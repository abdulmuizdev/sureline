import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/recommendation_algorithm/domain/repository/recommendation_algorithm_repository.dart';

class InitializeRecommendationAlgorithm {
  final RecommendationAlgorithmRepository repository;

  InitializeRecommendationAlgorithm(this.repository);

  Future<Either<Failure, void>> call() async {
    return repository.initialize();
  }
}
