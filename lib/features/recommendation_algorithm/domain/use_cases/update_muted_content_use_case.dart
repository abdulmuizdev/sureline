import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/recommendation_algorithm/domain/repository/recommendation_algorithm_repository.dart';

class UpdateMutedContentUseCase {
  final RecommendationAlgorithmRepository repository;

  UpdateMutedContentUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required bool withAuthor,
    required bool withoutAuthor,
  }) async {
    return repository.updateMutedContent(
      withAuthor: withAuthor,
      withoutAuthor: withoutAuthor,
    );
  }
}
