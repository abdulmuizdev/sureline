/// States for theme creation and editing.
///
/// Represents different states of theme customization operations.

import 'package:flutter/material.dart';

/// Abstract base class for all create theme states.
abstract class CreateThemeState {
  const CreateThemeState();
}

/// Initial state when no theme changes have been made.
class Initial extends CreateThemeState {
  const Initial();
}

/// State when text alignment is updated.
class UpdateTextAlignment extends CreateThemeState {
  /// The text alignment.
  final TextAlign textAlign;

  /// The icon alignment.
  final CrossAxisAlignment iconAlignment;

  /// Creates a new UpdateTextAlignment state.
  const UpdateTextAlignment(this.textAlign, this.iconAlignment);
}

/// State when text style is updated.
class UpdateTextStyle extends CreateThemeState {
  /// The text style.
  final TextStyle textStyle;

  /// The text color.
  final Color textColor;

  /// The font family.
  final String fontFamily;

  /// The outline state.
  final int outlineState;

  /// Creates a new UpdateTextStyle state.
  const UpdateTextStyle(this.textStyle, this.textColor, this.fontFamily, this.outlineState);
}

/// State when text padding is calculated.
class GotTextPadding extends CreateThemeState {
  /// The calculated padding value.
  final double padding;

  /// Creates a new GotTextPadding state.
  const GotTextPadding(this.padding);
}

/// State when slider value is updated.
class UpdateSliderValue extends CreateThemeState {
  /// The slider value.
  final double value;

  /// Creates a new UpdateSliderValue state.
  const UpdateSliderValue(this.value);
}

/// State when background is updated.
class UpdateBackground extends CreateThemeState {
  /// The background path.
  final String? path;

  /// Whether the image is from network.
  final bool? isNetwork;

  /// Whether the image is locally stored.
  final bool? isImageLocallyStored;

  /// The background color.
  final Color? color;

  /// The preview URL.
  final String? previewUrl;

  /// Creates a new UpdateBackground state.
  const UpdateBackground({
    this.path,
    this.isNetwork,
    this.isImageLocallyStored,
    this.color,
    this.previewUrl,
  });
}

/// State when theme is successfully changed.
class ThemeChanged extends CreateThemeState {
  /// Creates a new ThemeChanged state.
  const ThemeChanged();
}
