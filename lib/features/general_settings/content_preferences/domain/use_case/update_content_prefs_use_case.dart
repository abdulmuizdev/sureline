import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/content_preferences/domain/entity/content_pref_entity.dart';
import 'package:sureline/features/general_settings/content_preferences/domain/repository/content_pref_repository.dart';

class UpdateContentPrefsUseCase {
  final ContentPrefRepository repository;

  UpdateContentPrefsUseCase(this.repository);

  Future<Either<Failure, void>> execute(List<ContentPrefEntity> contentPrefs) {
    return repository.updateContentPrefs(contentPrefs);
  }
}
