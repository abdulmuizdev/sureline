import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/author_preferences/domain/entity/author_pref_entity.dart';
import 'package:sureline/features/general_settings/author_preferences/domain/repository/author_pref_repository.dart';

class GetAuthorPrefsUseCase {
  final AuthorPrefRepository repository;
  GetAuthorPrefsUseCase(this.repository);

  Either<Failure, List<AuthorPrefEntity>> execute() {
    return repository.getAuthorPrefs();
  }
}
