import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/data/model/author_pref_model.dart';
import 'package:sureline/features/recommendation_algorithm/domain/repository/recommendation_algorithm_repository.dart';

class GetAuthorPreferencesUseCase {
  final RecommendationAlgorithmRepository repository;

  GetAuthorPreferencesUseCase(this.repository);

  Future<Either<Failure, List<AuthorPrefModel>>> call() async {
    return repository.getAuthorPreferences();
  }
}
