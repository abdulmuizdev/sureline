/// Bloc for managing theme creation and editing.
///
/// Handles text styling, background selection, and theme customization.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sureline/common/domain/use_cases/change_theme_use_case.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/domain/use_case/download_photo_use_case.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/bloc/create_and_edit_theme_event.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/bloc/create_and_edit_theme_state.dart';

/// Bloc for managing create and edit theme functionality.
class CreateThemeBloc extends Bloc<CreateThemeEvent, CreateThemeState> {
  late String fontFamily;
  late double fontSize;
  late FontWeight fontWeight;
  late Color textColor;
  late int outlineState;
  late TextAlign textAlign;

  final minFontSize = 14;
  final maxFontSize = 35;

  final DownloadPhotoUseCase _downloadPhotoUseCase;
  final ChangeThemeUseCase _changeThemeUseCase;

  /// Creates a new CreateThemeBloc instance.
  CreateThemeBloc(this._downloadPhotoUseCase, this._changeThemeUseCase) : super(Initial()) {
    on<GetTextStyle>(_onGetTextStyle);
    on<OnTextAlignmentChange>(_onTextAlignmentChange);
    on<OnSliderValueChanged>(_onSliderValueChanged);
    on<OnFontFamilySelected>(_onFontFamilySelected);
    on<OnCameraIconPressed>(_onCameraIconPressed);
    on<OnUnsplashPhotoSelected>(_onUnsplashPhotoSelected);
    on<OnBackgroundColorSelected>(_onBackgroundColorSelected);
    on<OnTextColorSelected>(_onTextColorSelected);
    on<OnDonePressed>(_onDonePressed);
    on<OnOutlineStateChange>(_onOutlineStateChange);
  }

  /// Initializes the bloc with default values.
  void initialize({
    required String fontFamily,
    required double fontSize,
    required FontWeight fontWeight,
    required Color textColor,
    required int outlineState,
    required TextAlign textAlign,
  }) {
    this.fontFamily = fontFamily;
    this.fontSize = fontSize;
    this.fontWeight = fontWeight;
    this.textColor = textColor;
    this.outlineState = outlineState;
    this.textAlign = textAlign;
  }

  void _onGetTextStyle(GetTextStyle event, Emitter<CreateThemeState> emit) {
    emit(UpdateTextStyle(getTextStyle(), textColor, fontFamily, outlineState));
  }

  void _onTextAlignmentChange(OnTextAlignmentChange event, Emitter<CreateThemeState> emit) {
    switch (event.crossAxisAlignment) {
      case CrossAxisAlignment.start:
        emit(UpdateTextAlignment(TextAlign.center, CrossAxisAlignment.center));
      case CrossAxisAlignment.center:
        emit(UpdateTextAlignment(TextAlign.end, CrossAxisAlignment.end));
      case CrossAxisAlignment.end:
        emit(UpdateTextAlignment(TextAlign.start, CrossAxisAlignment.start));
      case CrossAxisAlignment.stretch:
        emit(UpdateTextAlignment(TextAlign.center, CrossAxisAlignment.center));
      case CrossAxisAlignment.baseline:
        emit(UpdateTextAlignment(TextAlign.center, CrossAxisAlignment.center));
    }
  }

  void _onSliderValueChanged(OnSliderValueChanged event, Emitter<CreateThemeState> emit) {
    emit(UpdateSliderValue(event.sliderValue));
    // Map slider value (0 to 1) to range (20 to 100)
    final relativeFontSize = minFontSize + (event.sliderValue * (maxFontSize - minFontSize));
    fontSize = relativeFontSize;

    final textStyle = getTextStyle();
    final padding = _getRelativeTextPadding(event.sliderValue);

    emit(GotTextPadding(padding));
    emit(UpdateTextStyle(textStyle, textColor, fontFamily, outlineState));
  }

  void _onFontFamilySelected(OnFontFamilySelected event, Emitter<CreateThemeState> emit) {
    fontFamily = event.fontFamily;

    final textStyle = getTextStyle();

    emit(UpdateTextStyle(textStyle, textColor, fontFamily, outlineState));
  }

  Future<void> _onCameraIconPressed(
    OnCameraIconPressed event,
    Emitter<CreateThemeState> emit,
  ) async {
    final XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      emit(UpdateBackground(path: file.path, isNetwork: false));
    }
  }

  Future<void> _onUnsplashPhotoSelected(
    OnUnsplashPhotoSelected event,
    Emitter<CreateThemeState> emit,
  ) async {
    final result = await _downloadPhotoUseCase.execute(event.path);
    result.fold((left) {}, (right) {
      emit(
        UpdateBackground(path: right, isImageLocallyStored: true, previewUrl: event.previewPath),
      );
    });
  }

  void _onBackgroundColorSelected(OnBackgroundColorSelected event, Emitter<CreateThemeState> emit) {
    emit(UpdateBackground(color: event.color));
  }

  void _onTextColorSelected(OnTextColorSelected event, Emitter<CreateThemeState> emit) {
    textColor = event.color;
    emit(UpdateTextStyle(getTextStyle(), textColor, fontFamily, outlineState));
  }

  Future<void> _onDonePressed(OnDonePressed event, Emitter<CreateThemeState> emit) async {
    await _changeThemeUseCase.execute(event.entity);
    HapticFeedback.lightImpact();
    emit(const ThemeChanged());
  }

  void _onOutlineStateChange(OnOutlineStateChange event, Emitter<CreateThemeState> emit) {
    outlineState = event.outlineState;
    emit(UpdateTextStyle(getTextStyle(), textColor, fontFamily, outlineState));
  }

  double _getRelativeTextPadding(double sliderValue) {
    var padding = 0.0;

    if (sliderValue <= 0.4) {
      padding = 18 * 2;
    } else if (sliderValue >= 0.4 && sliderValue <= 0.5) {
      padding = 18;
    } else if (sliderValue >= 0.5) {
      padding = 9;
    }

    return padding;
  }

  TextStyle getTextStyle() {
    Paint? paint;
    if (outlineState != 0) {
      paint =
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = double.parse(outlineState.toString())
            ..color = textColor;
    }

    return GoogleFonts.getFont(
      fontFamily,
      textStyle: TextStyle(
        foreground: paint,
        color: (outlineState == 0) ? textColor : null,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }

  CrossAxisAlignment getIconAlignment() {
    switch (textAlign) {
      case TextAlign.start:
        return CrossAxisAlignment.start;
      case TextAlign.center:
        return CrossAxisAlignment.center;
      case TextAlign.end:
        return CrossAxisAlignment.end;
      case TextAlign.left:
        return CrossAxisAlignment.start;
      case TextAlign.right:
        return CrossAxisAlignment.end;
      case TextAlign.justify:
        return CrossAxisAlignment.center;
    }
  }
}
