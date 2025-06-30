import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/author_preferences/domain/entity/author_pref_entity.dart';
import 'package:sureline/features/general_settings/author_preferences/domain/repository/author_pref_repository.dart';

class UpdateAuthorPrefsUseCase {
  final AuthorPrefRepository repository;

  UpdateAuthorPrefsUseCase(this.repository);

  Future<Either<Failure, void>> execute(List<AuthorPrefEntity> authorPrefs) {
    return repository.updateAuthorPrefs(authorPrefs);
  }
}
