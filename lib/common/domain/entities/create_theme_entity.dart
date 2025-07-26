/// Theme-related domain entities for the Sureline app.
///
/// This file contains the core domain entities for theme management, including:
/// - [ThemeEntity]: Main theme entity representing a complete theme configuration
/// - [ThemeBackgroundEntity]: Background configuration for themes
/// - [ThemeTextDecorEntity]: Text styling configuration for themes
///
/// These entities are used across the presentation layer for theme management,
/// customization, and display. They follow Clean Architecture principles by
/// being independent of data layer implementations.
///
/// Key Features:
/// - Immutable entities using Equatable for value equality
/// - Factory methods for converting from data models
/// - Comprehensive theming support (backgrounds, text styling, metadata)
/// - Support for various background types (network, local, solid colors, live)
/// - Text customization with fonts, colors, alignment, and effects
///
/// Usage:
/// ```dart
/// final theme = ThemeEntity(
///   id: 'theme_1',
///   lastAccessed: DateTime.now(),
///   backgroundEntity: ThemeBackgroundEntity(...),
///   textDecorEntity: ThemeTextDecorEntity(...),
///   previewQuote: 'Sample quote',
///   isFree: true,
///   isNew: false,
///   isSeasonal: false,
///   isMostPopular: false,
///   isUserCreated: false,
/// );
/// ```

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/data/model/theme_model.dart';

/// Represents a complete theme configuration in the domain layer.
///
/// A theme entity contains all the necessary information to display and customize
/// the appearance of quotes in the Sureline app. It includes background settings,
/// text styling, metadata, and various flags for categorization and filtering.
///
/// Properties:
/// - [id]: Unique identifier for the theme
/// - [lastAccessed]: Timestamp of when the theme was last used
/// - [previewQuote]: Sample quote used for theme preview
/// - [backgroundEntity]: Background configuration (image, color, effects)
/// - [textDecorEntity]: Text styling configuration (font, color, alignment)
/// - [isActive]: Whether this theme is currently selected
/// - [isFree]: Whether the theme is available for free
/// - [isNew]: Whether this is a newly added theme
/// - [isSeasonal]: Whether this theme is seasonal/holiday themed
/// - [isMostPopular]: Whether this is one of the most popular themes
/// - [isUserCreated]: Whether this theme was created by the user
///
/// The entity is immutable and uses Equatable for value-based equality comparison.
class ThemeEntity extends Equatable {
  final String? id;
  final DateTime lastAccessed;
  final String? previewQuote;
  final ThemeBackgroundEntity backgroundEntity;
  final ThemeTextDecorEntity textDecorEntity;
  final bool isActive;
  final bool isFree;
  final bool isNew;
  final bool isSeasonal;
  final bool isMostPopular;
  final bool isUserCreated;

  /// Creates a new [ThemeEntity] instance.
  ///
  /// [id] is optional and will be auto-generated if not provided.
  /// [lastAccessed] defaults to the current time.
  /// [isActive] defaults to false.
  /// All other boolean flags are required to explicitly define the theme's properties.
  ThemeEntity({
    required this.id,
    required this.lastAccessed,
    required this.textDecorEntity,
    required this.backgroundEntity,
    required this.previewQuote,
    this.isActive = false,
    required this.isFree,
    required this.isNew,
    required this.isSeasonal,
    required this.isMostPopular,
    required this.isUserCreated,
  });
  // : id = id ?? const Uuid().v4();

  @override
  List<Object?> get props => [
    previewQuote,
    backgroundEntity,
    textDecorEntity,
    isFree,
    isNew,
    isSeasonal,
    isMostPopular,
    isUserCreated,
  ];

  /// Creates a [ThemeEntity] from a [ThemeModel].
  ///
  /// This factory method converts a data layer model to a domain entity,
  /// maintaining the separation between data and domain layers.
  ///
  /// [model]: The data model to convert from
  /// Returns: A new [ThemeEntity] instance
  factory ThemeEntity.fromModel(ThemeModel model) {
    return ThemeEntity(
      lastAccessed: model.lastAccessed,
      textDecorEntity: ThemeTextDecorEntity.fromModel(model.textDecorModel),
      backgroundEntity: ThemeBackgroundEntity.fromModel(model.backgroundModel),
      previewQuote: model.previewQuote,
      isActive: model.isActive,
      id: model.id,
      isFree: model.isFree,
      isNew: model.isNew,
      isSeasonal: model.isSeasonal,
      isMostPopular: model.isMostPopular,
      isUserCreated: model.isUserCreated,
    );
  }
}

/// Represents the background configuration for a theme.
///
/// This entity handles all background-related settings including images,
/// solid colors, and special effects. It supports various background types:
/// - Network images (from Unsplash or other APIs)
/// - Locally stored images
/// - Solid color backgrounds
/// - Live/animated backgrounds
///
/// Properties:
/// - [path]: File path or URL for the background image
/// - [previewImage]: Thumbnail image for quick preview
/// - [solidColor]: Solid color for color-only backgrounds
/// - [isNetwork]: Whether the background is loaded from network
/// - [isLocallyStored]: Whether the background is stored locally
/// - [isLiveBackground]: Whether this is an animated/live background
///
/// The entity is immutable and uses Equatable for value-based equality comparison.
class ThemeBackgroundEntity extends Equatable {
  final String? path;
  final String? previewImage;
  final Color? solidColor;
  final bool isNetwork;
  final bool isLocallyStored;
  final bool isLiveBackground;

  /// Creates a new [ThemeBackgroundEntity] instance.
  ///
  /// [path] and [previewImage] are optional and depend on the background type.
  /// [solidColor] is used for solid color backgrounds.
  /// The boolean flags define the background type and storage location.
  const ThemeBackgroundEntity({
    required this.path,
    required this.isNetwork,
    required this.isLocallyStored,
    required this.solidColor,
    required this.isLiveBackground,
    this.previewImage,
  });

  @override
  List<Object?> get props => [
    path,
    previewImage,
    solidColor,
    isNetwork,
    isLiveBackground,
    isLocallyStored,
  ];

  /// Creates a [ThemeBackgroundEntity] from a [ThemeBackgroundModel].
  ///
  /// This factory method converts a data layer model to a domain entity.
  ///
  /// [model]: The data model to convert from
  /// Returns: A new [ThemeBackgroundEntity] instance
  factory ThemeBackgroundEntity.fromModel(ThemeBackgroundModel model) {
    return ThemeBackgroundEntity(
      path: model.path,
      previewImage: model.previewImage,
      isNetwork: model.isNetwork,
      isLocallyStored: model.isLocallyStored,
      solidColor: model.solidColor,
      isLiveBackground: model.isLiveBackground,
    );
  }
}

/// Represents the text styling configuration for a theme.
///
/// This entity handles all text-related styling including fonts, colors,
/// alignment, and special effects like outlines. It provides comprehensive
/// control over how quotes are displayed in the app.
///
/// Properties:
/// - [fontSize]: Size of the text in logical pixels
/// - [fontWeight]: Weight of the font (normal, bold, etc.)
/// - [fontFamily]: Font family name
/// - [textColor]: Color of the text
/// - [textAlign]: Text alignment (left, center, right, justify)
/// - [outlineState]: Outline effect state (0 = none, 1 = light, 2 = heavy)
/// - [textPadding]: Padding around the text
///
/// The entity is immutable and uses Equatable for value-based equality comparison.
/// It also provides a [copyWith] method for creating modified instances.
class ThemeTextDecorEntity extends Equatable {
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final Color textColor;
  final TextAlign textAlign;
  final int outlineState;
  final double textPadding;

  /// Creates a new [ThemeTextDecorEntity] instance.
  ///
  /// All parameters are required to ensure complete text styling configuration.
  /// [outlineState] should be 0 (none), 1 (light), or 2 (heavy).
  const ThemeTextDecorEntity({
    required this.fontSize,
    required this.fontWeight,
    required this.fontFamily,
    required this.textAlign,
    required this.textColor,
    required this.outlineState,
    required this.textPadding,
  });

  @override
  List<Object?> get props => [
    fontSize,
    fontWeight,
    fontFamily,
    textAlign,
    textColor,
    outlineState,
    textPadding,
  ];

  /// Creates a copy of this entity with the given fields replaced by new values.
  ///
  /// This method allows for immutable updates by creating a new instance
  /// with only the specified fields changed.
  ///
  /// All parameters are optional. If not provided, the current value is used.
  /// Returns: A new [ThemeTextDecorEntity] instance with updated values
  ThemeTextDecorEntity copyWith({
    double? fontSize,
    FontWeight? fontWeight,
    String? fontFamily,
    Color? textColor,
    TextAlign? textAlign,
    int? outlineState,
    double? textPadding,
  }) {
    return ThemeTextDecorEntity(
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontFamily: fontFamily ?? this.fontFamily,
      textAlign: textAlign ?? this.textAlign,
      textColor: textColor ?? this.textColor,
      outlineState: outlineState ?? this.outlineState,
      textPadding: textPadding ?? this.textPadding,
    );
  }

  /// Creates a [ThemeTextDecorEntity] from a [ThemeTextDecorModel].
  ///
  /// This factory method converts a data layer model to a domain entity.
  ///
  /// [model]: The data model to convert from
  /// Returns: A new [ThemeTextDecorEntity] instance
  factory ThemeTextDecorEntity.fromModel(ThemeTextDecorModel model) {
    return ThemeTextDecorEntity(
      fontSize: model.fontSize,
      fontWeight: model.fontWeight,
      fontFamily: model.fontFamily,
      textAlign: model.textAlign,
      textColor: model.textColor,
      outlineState: model.outlineState,
      textPadding: model.textPadding,
    );
  }
}
