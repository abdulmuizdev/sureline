import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/content_preferences/domain/entity/content_pref_entity.dart';

abstract class ContentPrefRepository {
  Future<Either<Failure, void>> updateContentPrefs(
    List<ContentPrefEntity> contentPrefs,
  );

  Either<Failure, List<ContentPrefEntity>> getContentPrefs();
}
