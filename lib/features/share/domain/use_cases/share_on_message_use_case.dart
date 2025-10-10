import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/share/domain/entity/share_entity.dart';
import 'package:sureline/features/share/domain/repository/share_repository.dart';

/// Shares content via messaging applications (iMessage, WhatsApp, Telegram, etc.).
///
/// Provides direct integration with messaging apps for quick content sharing.
/// Supports file attachments, message preview, and contact selection.
class ShareOnMessageUseCase {
  final ShareRepository repository;
  ShareOnMessageUseCase(this.repository);

  /// Opens messaging app with rendered post content attached.
  ///
  /// [entity] - Share entity containing file path and metadata
  /// Returns: Success or failure result
  Future<Either<Failure, void>> execute(ShareEntity entity) {
    return repository.shareOnMessage(entity);
  }
}
