/// Theme mix configurations for the Sureline app.
///
/// This file contains curated theme mixes and combinations
/// for the Sureline app. The [SurelineThemesMixes] class defines
/// a selection of themes that are grouped together for easy
/// access and user selection.
///
/// Key Features:
/// - Curated theme selections
/// - Theme categorization (Plain, Nature, Seasonal, etc.)
/// - Background and text styling combinations
/// - Theme metadata and filtering
/// - User-friendly theme organization
///
/// Usage:
/// ```dart
/// // Access theme mixes
/// var themeMixes = SurelineThemesMixes.values;
///
/// // Get specific theme mix
/// var natureTheme = themeMixes.firstWhere((t) => t.previewQuote == 'Nature');
/// ```

import 'package:flutter/material.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/theme/app_colors.dart';

/// Theme mix configuration class for the Sureline app.
///
/// This class defines curated theme mixes that provide users with
/// a selection of well-designed theme combinations. It offers a
/// simplified way to access and choose from a curated set of themes
/// with different styles and moods.
///
/// Responsibilities:
/// - Define curated theme selections
/// - Organize themes by style and mood
/// - Provide easy theme access
/// - Support theme categorization
/// - Enable quick theme selection
///
/// Theme Mix Categories:
/// - Plain: Simple, clean themes
/// - Nature: Natural and organic themes
/// - Seasonal: Season-specific themes
/// - Most Popular: Highly-rated themes
/// - Rain: Atmospheric themes
class SurelineThemesMixes {
  /// List of curated theme mix configurations.
  ///
  /// Contains a selection of well-designed theme combinations
  /// that users can easily choose from. Each theme includes:
  /// - Unique identifier
  /// - Background image or color
  /// - Text styling (font, color, size)
  /// - Preview quote for identification
  /// - Metadata (free, new, seasonal, popular)
  ///
  /// Available Mixes:
  /// - Plain: Simple background with default styling
  /// - Nature: Natural themes with white text
  /// - Seasonal: Seasonal themes with larger text
  /// - Most Popular: Popular themes with custom fonts
  /// - Rain: Atmospheric themes with white text
  ///
  /// Usage:
  /// ```dart
  /// // Get all theme mixes
  /// var themeMixes = SurelineThemesMixes.values;
  ///
  /// // Find specific theme mix
  /// var natureTheme = themeMixes.firstWhere((t) => t.previewQuote == 'Nature');
  /// var popularTheme = themeMixes.firstWhere((t) => t.previewQuote == 'Most Popular');
  ///
  /// // Filter by category
  /// var seasonalThemes = themeMixes.where((t) => t.isSeasonal);
  /// var newThemes = themeMixes.where((t) => t.isNew);
  /// ```
  static final List<ThemeEntity> values = [
    ThemeEntity(
      id: 'sureline-theme-2',
      lastAccessed: DateTime.now(),
      textDecorEntity: App.defaultTheme.textDecorEntity,
      backgroundEntity: const ThemeBackgroundEntity(
        path: 'assets/images/background.png',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: false,
        isLocallyStored: false,
      ),
      previewQuote: 'Plain',
      isFree: true,
      isNew: false,
      isSeasonal: false,
      isMostPopular: false,
      isUserCreated: false,
    ),
    ThemeEntity(
      id: 'sureline-theme-3',
      lastAccessed: DateTime.now(),
      textDecorEntity: App.defaultTheme.textDecorEntity.copyWith(textColor: AppColors.pureWhite),
      backgroundEntity: const ThemeBackgroundEntity(
        path: 'assets/images/theme/leaves.jpg',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: false,
        isLocallyStored: false,
      ),
      previewQuote: 'Nature',
      isFree: true,
      isNew: true,
      isSeasonal: false,
      isMostPopular: true,
      isUserCreated: false,
    ),
    ThemeEntity(
      id: 'sureline-theme-6',
      lastAccessed: DateTime.now(),
      textDecorEntity: App.defaultTheme.textDecorEntity.copyWith(
        textColor: AppColors.pureWhite,
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
      backgroundEntity: const ThemeBackgroundEntity(
        path: 'assets/images/theme/sunset.jpg',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: false,
        isLocallyStored: false,
      ),
      previewQuote: 'Seasonal',
      isFree: true,
      isNew: true,
      isSeasonal: true,
      isMostPopular: false,
      isUserCreated: false,
    ),
    ThemeEntity(
      id: 'sureline-theme-8',
      lastAccessed: DateTime.now(),
      textDecorEntity: App.defaultTheme.textDecorEntity.copyWith(
        textColor: const Color(0xFF333333),
        fontFamily: 'Playfair Display',
        fontSize: 26,
      ),
      backgroundEntity: const ThemeBackgroundEntity(
        path: 'assets/images/theme/heaven.jpg',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: false,
        isLocallyStored: false,
      ),
      previewQuote: 'Most Popular',
      isFree: true,
      isNew: true,
      isSeasonal: false,
      isMostPopular: true,
      isUserCreated: false,
    ),
    ThemeEntity(
      id: 'sureline-theme-9',
      lastAccessed: DateTime.now(),
      textDecorEntity: App.defaultTheme.textDecorEntity.copyWith(textColor: AppColors.pureWhite),
      backgroundEntity: const ThemeBackgroundEntity(
        path: 'assets/images/theme/dark_rain.jpg',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: false,
        isLocallyStored: false,
      ),
      previewQuote: 'Rain',
      isFree: true,
      isNew: true,
      isSeasonal: false,
      isMostPopular: false,
      isUserCreated: false,
    ),
  ];
}
