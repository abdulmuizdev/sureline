import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/share/domain/entity/render_entity.dart';
import 'package:sureline/features/share/domain/repository/share_repository.dart';

/// Use case for rendering video posts with animations and live backgrounds.
class RenderVideoPostUseCase {
  final ShareRepository _repository;

  RenderVideoPostUseCase(this._repository);

  /// Executes video rendering.
  /// [renderEntity] - The render entity containing video configuration
  /// Returns: Either a failure or success result
  Future<Either<Failure, void>> execute(RenderEntity renderEntity) async {
    return await _repository.startRenderingVideoPost(renderEntity);
  }
}
