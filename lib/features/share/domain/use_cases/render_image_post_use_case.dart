import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/share/domain/entity/render_entity.dart';
import 'package:sureline/features/share/domain/repository/share_repository.dart';

class RenderImagePostUseCase {
  final ShareRepository shareRepository;

  RenderImagePostUseCase(this.shareRepository);

  Future<Either<Failure, String>> execute(RenderEntity entity) {
    debugPrint('use case called');
    return shareRepository.startRenderingImagePost(entity);
  }
}
