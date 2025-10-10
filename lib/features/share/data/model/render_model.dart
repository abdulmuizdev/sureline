import 'package:sureline/features/share/domain/entity/render_entity.dart';

class RenderModel extends RenderEntity {
  const RenderModel({
    required super.quote,
    required super.path,
    required super.isLiveBackground,
    required super.quoteKey,
    required super.rootKey,
  });

  factory RenderModel.fromEntity(RenderEntity entity) {
    return RenderModel(
      quote: entity.quote,
      path: entity.path,
      isLiveBackground: entity.isLiveBackground,
      quoteKey: entity.quoteKey,
      rootKey: entity.rootKey,
    );
  }
}
