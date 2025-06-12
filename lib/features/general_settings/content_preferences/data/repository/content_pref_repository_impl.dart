import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/content_preferences/data/data_source/content_prefs_data_source.dart';
import 'package:sureline/features/general_settings/content_preferences/data/model/content_pref_model.dart';
import 'package:sureline/features/general_settings/content_preferences/domain/entity/content_pref_entity.dart';
import 'package:sureline/features/general_settings/content_preferences/domain/repository/content_pref_repository.dart';

class ContentPrefRepositoryImpl extends ContentPrefRepository {
  final ContentPrefsDataSource dataSource;

  ContentPrefRepositoryImpl(this.dataSource);

  @override
  Either<Failure, List<ContentPrefEntity>> getContentPrefs() {
    return dataSource.getContentPrefs();
  }

  @override
  Future<Either<Failure, void>> updateContentPrefs(
    List<ContentPrefEntity> contentPrefs,
  ) {
    return dataSource.updateContentPrefs(
      contentPrefs
          .map((entity) => ContentPrefModel.fromEntity(entity))
          .toList(),
    );
  }
}
