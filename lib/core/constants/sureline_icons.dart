/// App icon configuration constants for the Sureline app.
///
/// This file contains icon-related constants and configurations
/// for the Sureline app. The [SurelineIcons] class defines
/// all available app icons for user selection and customization.
///
/// Key Features:
/// - App icon model definitions
/// - iOS and Android icon support
/// - Default and alternate icon options
/// - Asset path management
///
/// Usage:
/// ```dart
/// // Access all available app icons
/// var icons = SurelineIcons.values;
///
/// // Get the default icon
/// var defaultIcon = icons.firstWhere((i) => i.isDefaultIcon);
/// ```

import 'package:sureline/features/onboarding/icon_selection/data/models/icon_model.dart';

/// App icon configuration class for the Sureline app.
///
/// This class defines all the available app icons for the Sureline app,
/// including their asset paths, iOS and Android icon names, and default status.
/// It provides a centralized location for icon management and user customization.
///
/// Responsibilities:
/// - Define available app icon configurations
/// - Support iOS and Android icon selection
/// - Manage default and alternate icon options
/// - Enable user customization of app appearance
///
/// Icon Features:
/// - Asset paths for icon previews
/// - iOS icon names for alternate icon support
/// - Android icon placeholders (currently 'null')
/// - Default icon identification
class SurelineIcons {
  /// List of available app icon configurations.
  ///
  /// Contains all predefined app icons with their asset paths,
  /// iOS and Android icon names, and default status. Each icon includes:
  /// - Preview asset path
  /// - iOS icon name
  /// - Android icon name (currently 'null')
  /// - Default icon flag
  ///
  /// Usage:
  /// ```dart
  /// // Get all available app icons
  /// var icons = SurelineIcons.values;
  ///
  /// // Find the default icon
  /// var defaultIcon = icons.firstWhere((i) => i.isDefaultIcon);
  ///
  /// // List all alternate icons
  /// var alternateIcons = icons.where((i) => !i.isDefaultIcon);
  /// ```
  static final List<IconModel> values = [
    IconModel(
      previewPath: 'assets/images/one.png',
      iOSIcon: 'AppIcon1',
      androidIcon: 'null',
      isDefaultIcon: true,
    ),
    IconModel(
      previewPath: 'assets/images/two.png',
      iOSIcon: 'AppIcon2',
      androidIcon: 'null',
      isDefaultIcon: false,
    ),
    IconModel(
      previewPath: 'assets/images/three.png',
      iOSIcon: 'AppIcon3',
      androidIcon: 'null',
      isDefaultIcon: false,
    ),
    IconModel(
      previewPath: 'assets/images/four.png',
      iOSIcon: 'AppIcon4',
      androidIcon: 'null',
      isDefaultIcon: false,
    ),
    IconModel(
      previewPath: 'assets/images/five.png',
      iOSIcon: 'AppIcon5',
      androidIcon: 'null',
      isDefaultIcon: false,
    ),
    IconModel(
      previewPath: 'assets/images/six.png',
      iOSIcon: 'AppIcon6',
      androidIcon: 'null',
      isDefaultIcon: false,
    ),
    IconModel(
      previewPath: 'assets/images/seven.png',
      iOSIcon: 'AppIcon7',
      androidIcon: 'null',
      isDefaultIcon: false,
    ),
    IconModel(
      previewPath: 'assets/images/eight.png',
      iOSIcon: 'AppIcon8',
      androidIcon: 'null',
      isDefaultIcon: false,
    ),
    IconModel(
      previewPath: 'assets/images/nine.png',
      iOSIcon: 'AppIcon9',
      androidIcon: 'null',
      isDefaultIcon: false,
    ),
  ];
}
