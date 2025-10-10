import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/share/domain/entity/render_entity.dart';
import 'package:sureline/features/share/domain/repository/share_repository.dart';

/// Renders quotes as static images with custom styling and backgrounds.
///
/// Creates high-quality images optimized for social media sharing.
/// Supports custom typography, background integration, and platform-specific formatting.
class RenderImagePostUseCase {
  final ShareRepository shareRepository;

  RenderImagePostUseCase(this.shareRepository);

  /// Renders quote as image with styling and background integration.
  ///
  /// [entity] - Render entity with quote and styling data
  /// Returns: Image file path or failure
  Future<Either<Failure, String>> execute(RenderEntity entity) {
    debugPrint('use case called');
    return shareRepository.startRenderingImagePost(entity);
  }
}
