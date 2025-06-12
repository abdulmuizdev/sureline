import 'package:sureline/core/libraries/direct_social_share/direct_social_share_schemas.dart';
import 'package:sureline/features/share/domain/entity/render_entity.dart';

class ShareEntity {
  final SocialShareSchema schema;
  final String? path;
  final RenderEntity renderEntity;

  const ShareEntity({required this.schema, this.path, required this.renderEntity});
}