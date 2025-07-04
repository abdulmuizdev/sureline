import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/data/model/author_pref_model.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/domain/entity/author_pref_entity.dart';
import 'package:sureline/features/recommendation_algorithm/domain/repository/recommendation_algorithm_repository.dart';

class UpdateAuthorPreferenceUseCase {
  final RecommendationAlgorithmRepository repository;

  UpdateAuthorPreferenceUseCase(this.repository);

  Future<Either<Failure, void>> call(AuthorPrefEntity authorPrefEntity) async {
    return repository.updateAuthorPreference(
      AuthorPrefModel.fromEntity(authorPrefEntity),
    );
  }
}
