import 'package:flutter_app_icon_changer/flutter_app_icon_changer.dart';

/// Domain entity representing an app icon configuration.
/// This entity extends AppIcon from the flutter_app_icon_changer package
/// and adds a preview path for displaying the icon in the selection UI.
///
/// The entity contains all necessary information for both displaying
/// and changing the app icon, including platform-specific icon paths.
class IconEntity extends AppIcon {
  IconEntity({
    required this.previewPath,
    required super.iOSIcon,
    required super.androidIcon,
    required super.isDefaultIcon,
  });

  /// The asset path for the icon preview image used in the selection UI.
  /// This path points to the image that will be displayed in the icon grid.
  final String previewPath;
}
