import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/domain/repository/create_and_edit_theme_repository.dart';

class DownloadPhotoUseCase {
  final CreateThemeRepository repository;

  DownloadPhotoUseCase(this.repository);

  Future<Either<Failure, String>> execute(String path) {
    return repository.downloadPhoto(path);
  }
}
