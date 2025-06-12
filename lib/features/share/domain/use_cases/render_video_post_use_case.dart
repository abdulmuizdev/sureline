import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/share/domain/entity/render_entity.dart';
import 'package:sureline/features/share/domain/repository/share_repository.dart';

class RenderVideoPostUseCase {
  final ShareRepository shareRepository;

  RenderVideoPostUseCase(this.shareRepository);

  Future<Either<Failure, void>> execute(RenderEntity entity) {
    return shareRepository.startRenderingVideoPost(entity);
  }
}
