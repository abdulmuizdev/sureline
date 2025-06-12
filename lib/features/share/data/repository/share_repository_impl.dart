import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/share/data/data_source/share_data_source.dart';
import 'package:sureline/features/share/data/model/render_model.dart';
import 'package:sureline/features/share/data/model/render_result_model.dart';
import 'package:sureline/features/share/data/model/share_model.dart';
import 'package:sureline/features/share/domain/entity/render_entity.dart';
import 'package:sureline/features/share/domain/entity/render_result_entity.dart';
import 'package:sureline/features/share/domain/entity/share_entity.dart';
import 'package:sureline/features/share/domain/repository/share_repository.dart';

class ShareRepositoryImpl extends ShareRepository {
  final ShareDataSource shareDataSource;

  ShareRepositoryImpl(this.shareDataSource);

  @override
  void disposeStream() {
    return shareDataSource.disposeStream();
  }

  @override
  Stream<RenderResultEntity> renderResultStream() {
    return shareDataSource.renderResultStream();
  }

  @override
  Future<Either<Failure, void>> saveFile(String path) {
    return shareDataSource.saveFile(path);
  }

  @override
  Future<Either<Failure, void>> shareOnSocial(ShareEntity entity) {
    return shareDataSource.shareOnSocial(ShareModel.fromEntity(entity));
  }

  @override
  Future<Either<Failure, void>> startRenderingVideoPost(RenderEntity entity) {
    return shareDataSource.startRenderingVideoPost(RenderModel.fromEntity(entity));
  }

  @override
  Future<Either<Failure, void>> shareOnMessage(ShareEntity entity) {
    return shareDataSource.shareOnMessages(ShareModel.fromEntity(entity));
  }

  @override
  Future<Either<Failure, void>> shareOnDefault(ShareEntity entity) {
    return shareDataSource.shareOnDefault(ShareModel.fromEntity(entity));
  }

  @override
  Future<Either<Failure, String>> startRenderingImagePost(RenderEntity entity) {
    return shareDataSource.startRenderingImagePost(RenderModel.fromEntity(entity));
  }
}
