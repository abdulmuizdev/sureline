import 'package:flutter/material.dart';

abstract class CreateThemeState {
  const CreateThemeState();
}

class Initial extends CreateThemeState {}

class UpdateTextAlignment extends CreateThemeState {
  final TextAlign textAlign;
  final CrossAxisAlignment iconAlignment;
  UpdateTextAlignment(this.textAlign, this.iconAlignment);
}

class UpdateTextStyle extends CreateThemeState {
  final TextStyle textStyle;
  final Color textColor;
  final String fontFamily;
  final int outlineState;
  UpdateTextStyle(
    this.textStyle,
    this.textColor,
    this.fontFamily,
    this.outlineState,
  );
}

class GotTextPadding extends CreateThemeState {
  final double padding;

  GotTextPadding(this.padding);
}

class UpdateSliderValue extends CreateThemeState {
  final double value;
  const UpdateSliderValue(this.value);
}

class UpdateBackground extends CreateThemeState {
  final String? path;
  final bool? isNetwork;
  final bool? isImageLocallyStored;
  final Color? color;
  final String? previewUrl;
  const UpdateBackground({
    this.path,
    this.isNetwork,
    this.color,
    this.isImageLocallyStored,
    this.previewUrl,
  });
}

class ThemeChanged extends CreateThemeState {
  const ThemeChanged();
}
