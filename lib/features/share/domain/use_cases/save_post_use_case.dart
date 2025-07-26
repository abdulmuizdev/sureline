import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/share/domain/repository/share_repository.dart';

/// Saves rendered posts to device storage (photo library/gallery).
///
/// Handles storage permissions, file organization, and device integration.
/// Supports both image and video formats with automatic file naming.
class SavePostUseCase {
  final ShareRepository repository;

  SavePostUseCase(this.repository);

  /// Saves rendered post file to device storage.
  ///
  /// [path] - File path of the rendered post to save
  /// Returns: Success or failure result
  Future<Either<Failure, void>> execute(String path) {
    return repository.saveFile(path);
  }
}
