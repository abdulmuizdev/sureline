import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/author_preferences/data/data_source/author_prefs_data_source.dart';
import 'package:sureline/features/general_settings/author_preferences/data/model/author_pref_model.dart';
import 'package:sureline/features/general_settings/author_preferences/domain/entity/author_pref_entity.dart';
import 'package:sureline/features/general_settings/author_preferences/domain/repository/author_pref_repository.dart';

class AuthorPrefRepositoryImpl extends AuthorPrefRepository {
  final AuthorPrefsDataSource dataSource;

  AuthorPrefRepositoryImpl(this.dataSource);

  @override
  Either<Failure, List<AuthorPrefEntity>> getAuthorPrefs() {
    return dataSource.getAuthorPrefs();
  }

  @override
  Future<Either<Failure, void>> updateAuthorPrefs(
    List<AuthorPrefEntity> authorPrefs,
  ) {
    return dataSource.updateAuthorPrefs(
      authorPrefs.map((entity) => AuthorPrefModel.fromEntity(entity)).toList(),
    );
  }
}
