import 'package:flutter/material.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';

abstract class CreateThemeEvent {
  const CreateThemeEvent();
}

class GetTextStyle extends CreateThemeEvent {
  GetTextStyle();
}

class OnSliderValueChanged extends CreateThemeEvent {
  final double sliderValue;
  const OnSliderValueChanged(this.sliderValue);
}

class OnFontFamilySelected extends CreateThemeEvent {
  final String fontFamily;
  const OnFontFamilySelected(this.fontFamily);
}

class OnTextAlignmentChange extends CreateThemeEvent {
  final CrossAxisAlignment crossAxisAlignment;
  const OnTextAlignmentChange(this.crossAxisAlignment);
}

class OnCameraIconPressed extends CreateThemeEvent {
  const OnCameraIconPressed();
}

class OnUnsplashPhotoSelected extends CreateThemeEvent {
  final String path;
  final String previewPath;
  const OnUnsplashPhotoSelected({
    required this.path,
    required this.previewPath,
  });
}

class OnBackgroundColorSelected extends CreateThemeEvent {
  final Color color;
  const OnBackgroundColorSelected(this.color);
}

class OnTextColorSelected extends CreateThemeEvent {
  final Color color;
  const OnTextColorSelected(this.color);
}

class OnDonePressed extends CreateThemeEvent {
  final ThemeEntity entity;
  const OnDonePressed({required this.entity});
}

class OnOutlineStateChange extends CreateThemeEvent {
  final int outlineState;
  const OnOutlineStateChange(this.outlineState);
}
