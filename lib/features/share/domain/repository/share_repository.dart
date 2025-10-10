import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/share/domain/entity/render_entity.dart';
import 'package:sureline/features/share/domain/entity/render_result_entity.dart';
import 'package:sureline/features/share/domain/entity/share_entity.dart';

abstract class ShareRepository {
  Future<Either<Failure, void>> shareOnSocial(ShareEntity entity);

  Future<Either<Failure, void>> shareOnMessage(ShareEntity entity);

  Future<Either<Failure, void>> shareOnDefault(ShareEntity entity);

  Future<Either<Failure, void>> saveFile(String path);

  Future<Either<Failure, void>> startRenderingVideoPost(RenderEntity entity);

  Future<Either<Failure, String>> startRenderingImagePost(RenderEntity entity);

  Stream<RenderResultEntity> renderResultStream();

  void disposeStream();
}