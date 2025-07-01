import 'package:sureline/features/general_settings/muted_content/domain/entity/muted_content_entity.dart';

class MutedContentModel extends MutedContentEntity {
  MutedContentModel({
    required super.isWithAuthorMuted,
    required super.isWithoutAuthorMuted,
  });
}
