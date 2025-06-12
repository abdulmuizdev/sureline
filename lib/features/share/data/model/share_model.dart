import 'package:sureline/features/share/domain/entity/share_entity.dart';

class ShareModel extends ShareEntity {
  const ShareModel({
    required super.schema,
    super.path,
    required super.renderEntity,
  });

  factory ShareModel.fromEntity(ShareEntity entity) {
    return ShareModel(
      schema: entity.schema,
      path: entity.path,
      renderEntity: entity.renderEntity,
    );
  }
}
