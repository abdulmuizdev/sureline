import 'package:sureline/features/onboarding/icon_selection/domain/entity/icon_entity.dart';

/// Data model for app icon configuration in the data layer.
/// This model extends IconEntity and provides the data layer representation
/// for app icon configurations used in the icon selection feature.
///
/// The model maintains the same structure as the domain entity,
/// ensuring proper data flow between layers.
class IconModel extends IconEntity {
  IconModel({
    required super.previewPath,
    required super.iOSIcon,
    required super.androidIcon,
    required super.isDefaultIcon,
  });
}
