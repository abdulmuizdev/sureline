import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/share/domain/entity/share_entity.dart';
import 'package:sureline/features/share/domain/repository/share_repository.dart';

/// Shares content via native system share sheet.
///
/// Provides access to all available sharing options on device including
/// messaging apps, email, cloud storage, and installed applications.
class ShareOnDefaultUseCase {
  final ShareRepository repository;
  ShareOnDefaultUseCase(this.repository);

  /// Presents native share sheet with rendered post content.
  ///
  /// [entity] - Share entity containing file path and metadata
  /// Returns: Success or failure result
  Future<Either<Failure, void>> execute(ShareEntity entity) {
    return repository.shareOnDefault(entity);
  }
}
