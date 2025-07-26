/// Repository interface for theme creation operations.
///
/// Defines operations for theme customization and photo management.

import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';

/// Abstract repository for create theme operations.
abstract class CreateThemeRepository {
  /// Downloads a photo from the given path.
  ///
  /// [path]: URL or path of the photo to download
  /// Returns: Either a failure or the local file path
  Future<Either<Failure, String>> downloadPhoto(String path);
}
