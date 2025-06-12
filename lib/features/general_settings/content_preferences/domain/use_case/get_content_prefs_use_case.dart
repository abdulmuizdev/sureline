import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/content_preferences/domain/entity/content_pref_entity.dart';
import 'package:sureline/features/general_settings/content_preferences/domain/repository/content_pref_repository.dart';

class GetContentPrefsUseCase {
  final ContentPrefRepository repository;
  GetContentPrefsUseCase(this.repository);

  Either<Failure, List<ContentPrefEntity>> execute() {
    return repository.getContentPrefs();
  }
}