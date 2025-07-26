/// Events for theme creation and editing.
///
/// Handles user interactions for theme customization.

import 'package:flutter/material.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';

/// Abstract base class for all create theme events.
abstract class CreateThemeEvent {
  const CreateThemeEvent();
}

/// Event to get the current text style.
class GetTextStyle extends CreateThemeEvent {
  /// Creates a new GetTextStyle event.
  const GetTextStyle();
}

/// Event when slider value changes.
class OnSliderValueChanged extends CreateThemeEvent {
  /// The new slider value.
  final double sliderValue;

  /// Creates a new OnSliderValueChanged event.
  const OnSliderValueChanged(this.sliderValue);
}

/// Event when a font family is selected.
class OnFontFamilySelected extends CreateThemeEvent {
  /// The selected font family.
  final String fontFamily;

  /// Creates a new OnFontFamilySelected event.
  const OnFontFamilySelected(this.fontFamily);
}

/// Event when text alignment changes.
class OnTextAlignmentChange extends CreateThemeEvent {
  /// The new cross axis alignment.
  final CrossAxisAlignment crossAxisAlignment;

  /// Creates a new OnTextAlignmentChange event.
  const OnTextAlignmentChange(this.crossAxisAlignment);
}

/// Event when camera icon is pressed.
class OnCameraIconPressed extends CreateThemeEvent {
  /// Creates a new OnCameraIconPressed event.
  const OnCameraIconPressed();
}

/// Event when an Unsplash photo is selected.
class OnUnsplashPhotoSelected extends CreateThemeEvent {
  /// The path of the selected photo.
  final String path;

  /// The preview path of the selected photo.
  final String previewPath;

  /// Creates a new OnUnsplashPhotoSelected event.
  const OnUnsplashPhotoSelected({required this.path, required this.previewPath});
}

/// Event when a background color is selected.
class OnBackgroundColorSelected extends CreateThemeEvent {
  /// The selected background color.
  final Color color;

  /// Creates a new OnBackgroundColorSelected event.
  const OnBackgroundColorSelected(this.color);
}

/// Event when a text color is selected.
class OnTextColorSelected extends CreateThemeEvent {
  /// The selected text color.
  final Color color;

  /// Creates a new OnTextColorSelected event.
  const OnTextColorSelected(this.color);
}

/// Event when done button is pressed.
class OnDonePressed extends CreateThemeEvent {
  /// The theme entity to save.
  final ThemeEntity entity;

  /// Creates a new OnDonePressed event.
  const OnDonePressed({required this.entity});
}

/// Event when outline state changes.
class OnOutlineStateChange extends CreateThemeEvent {
  /// The new outline state.
  final int outlineState;

  /// Creates a new OnOutlineStateChange event.
  const OnOutlineStateChange(this.outlineState);
}
