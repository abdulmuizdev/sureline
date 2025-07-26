import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/share/domain/entity/share_entity.dart';
import 'package:sureline/features/share/domain/repository/share_repository.dart';

/// Handles social media platform sharing with platform-specific optimization.
///
/// Supports Instagram, Facebook, Twitter, TikTok, LinkedIn, Pinterest.
/// Optimizes content format and size for each platform's requirements.
class ShareOnSocialUseCase {
  final ShareRepository repository;

  ShareOnSocialUseCase(this.repository);

  /// Shares content on social media platforms with platform-specific formatting.
  ///
  /// [entity] - Share entity containing file path and platform metadata
  /// Returns: Success or failure result
  Future<Either<Failure, void>> execute(ShareEntity entity) {
    return repository.shareOnSocial(entity);
  }
}
