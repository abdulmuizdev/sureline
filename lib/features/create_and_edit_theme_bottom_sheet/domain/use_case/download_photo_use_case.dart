/// Downloads photos for theme backgrounds.
///
/// Handles photo download operations for theme customization.

import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/domain/repository/create_and_edit_theme_repository.dart';

/// Use case for downloading photos.
class DownloadPhotoUseCase {
  final CreateThemeRepository repository;

  /// Creates a new DownloadPhotoUseCase instance.
  const DownloadPhotoUseCase(this.repository);

  /// Executes the download photo operation.
  ///
  /// [path]: URL or path of the photo to download
  /// Returns: Either a failure or the local file path
  Future<Either<Failure, String>> execute(String path) {
    return repository.downloadPhoto(path);
  }
}
