import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/author_preferences/domain/entity/author_pref_entity.dart';

abstract class AuthorPrefRepository {
  Future<Either<Failure, void>> updateAuthorPrefs(
    List<AuthorPrefEntity> authorPrefs,
  );

  Either<Failure, List<AuthorPrefEntity>> getAuthorPrefs();
}
