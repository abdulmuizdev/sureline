import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/muted_content/domain/entity/muted_content_entity.dart';
import 'package:sureline/features/recommendation_algorithm/domain/repository/recommendation_algorithm_repository.dart';

class GetMutedContentUseCase {
  final RecommendationAlgorithmRepository repository;

  GetMutedContentUseCase(this.repository);

  Future<Either<Failure, List<MutedContentEntity>>> call() async {
    return repository.getMutedContent();
  }
}
