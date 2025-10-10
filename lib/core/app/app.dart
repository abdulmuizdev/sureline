/// Core application configuration and global state management.

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/constants/constants.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/remote_config/domain/entities/remote_config_entity.dart';
import 'package:uuid/uuid.dart';

/// Core application class for global state and configuration management.
class App {
  /// Global volume setting for the application.
  static double volume = Constants.defaultVolume;

  /// Global voice configuration map.
  static Map<String, String>? voice;

  /// Remote configuration entity for feature flags and settings.
  static RemoteConfigEntity remoteConfigEntity = Constants.remoteConfigModel;

  /// ValueKey for the home screen quote widget.
  static ValueKey homeScreenQuoteKey = const ValueKey('quote_0');

  /// Default theme configuration for the application.
  static ThemeEntity defaultTheme = ThemeEntity(
    id: const Uuid().v4(),
    lastAccessed: DateTime.now(),
    textDecorEntity: const ThemeTextDecorEntity(
      fontSize: Constants.defaultFontSize,
      fontWeight: Constants.defaultFontWeight,
      fontFamily: Constants.defaultFontFamily,
      textAlign: TextAlign.center,
      textColor: AppColors.primaryColor,
      outlineState: 0,
      textPadding: 18,
    ),
    backgroundEntity: const ThemeBackgroundEntity(
      path: Constants.defaultBackground,
      isNetwork: false,
      solidColor: null,
      isLiveBackground: false,
      isLocallyStored: false,
    ),
    previewQuote: null,
    isFree: false,
    isNew: false,
    isSeasonal: false,
    isMostPopular: false,
    isUserCreated: false,
  );

  /// Current theme entity for the application.
  static ThemeEntity themeEntity = defaultTheme;

  /// Primary action color for home screen elements.
  static Color homeActionColor = AppColors.primaryColor;

  /// Background color for home screen buttons.
  static Color homeButtonColor = AppColors.pureWhite;

  /// Solid background color for the application.
  static Color? bgSolidColor;

  /// Premium status for the application.
  static bool isPremium = false;
}
