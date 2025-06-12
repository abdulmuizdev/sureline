import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sureline/common/domain/use_cases/change_theme_use_case.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/domain/use_case/download_photo_use_case.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/bloc/create_and_edit_theme_event.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/bloc/create_and_edit_theme_state.dart';

class CreateThemeBloc extends Bloc<CreateThemeEvent, CreateThemeState> {
  late String fontFamily;
  late double fontSize;
  late FontWeight fontWeight;
  late Color textColor;
  late int outlineState;
  late TextAlign textAlign;

  final minFontSize = 14;
  final maxFontSize = 35;

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

  final DownloadPhotoUseCase _downloadPhotoUseCase;
  final ChangeThemeUseCase _changeThemeUseCase;

  CreateThemeBloc(this._downloadPhotoUseCase, this._changeThemeUseCase)
    : super(Initial()) {
    on<GetTextStyle>((event, emit) {
      emit(
        UpdateTextStyle(getTextStyle(), textColor, fontFamily, outlineState),
      );
    });

    on<OnTextAlignmentChange>((event, emit) {
      switch (event.crossAxisAlignment) {
        case CrossAxisAlignment.start:
          emit(
            UpdateTextAlignment(TextAlign.center, CrossAxisAlignment.center),
          );
          break;

        case CrossAxisAlignment.center:
          emit(UpdateTextAlignment(TextAlign.end, CrossAxisAlignment.end));
          break;

        case CrossAxisAlignment.end:
          emit(UpdateTextAlignment(TextAlign.start, CrossAxisAlignment.start));
          break;

        default:
          emit(
            UpdateTextAlignment(TextAlign.center, CrossAxisAlignment.center),
          );
          break;
      }
    });

    on<OnSliderValueChanged>((event, emit) {
      emit(UpdateSliderValue(event.sliderValue));
      // Map slider value (0 to 1) to range (20 to 100)
      final relativeFontSize =
          minFontSize + (event.sliderValue * (maxFontSize - minFontSize));
      fontSize = relativeFontSize;

      final textStyle = getTextStyle();
      final padding = _getRelativeTextPadding(event.sliderValue);

      emit(GotTextPadding(padding));
      emit(UpdateTextStyle(textStyle, textColor, fontFamily, outlineState));
    });

    on<OnFontFamilySelected>((event, emit) {
      fontFamily = event.fontFamily;

      final textStyle = getTextStyle();

      emit(UpdateTextStyle(textStyle, textColor, fontFamily, outlineState));
    });

    on<OnCameraIconPressed>((event, emit) async {
      final XFile? file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (file != null) {
        emit(UpdateBackground(path: file.path, isNetwork: false));
      }
    });

    on<OnUnsplashPhotoSelected>((event, emit) async {
      final result = await _downloadPhotoUseCase.execute(event.path);
      result.fold((left) {}, (right) {
        emit(
          UpdateBackground(
            path: right,
            isImageLocallyStored: true,
            previewUrl: event.previewPath,
          ),
        );
      });
    });

    on<OnBackgroundColorSelected>((event, emit) {
      emit(UpdateBackground(color: event.color));
    });

    on<OnTextColorSelected>((event, emit) {
      textColor = event.color;
      emit(
        UpdateTextStyle(getTextStyle(), textColor, fontFamily, outlineState),
      );
    });

    on<OnDonePressed>((event, emit) async {
      await _changeThemeUseCase.execute(event.entity);
      HapticFeedback.lightImpact();
      emit(ThemeChanged());
    });

    on<OnOutlineStateChange>((event, emit) {
      outlineState = event.outlineState;
      emit(
        UpdateTextStyle(getTextStyle(), textColor, fontFamily, outlineState),
      );
    });
  }

  double _getRelativeTextPadding(double sliderValue) {
    var padding = 0.0;

    if (sliderValue <= 0.4) padding = 18 * (2);

    if (sliderValue >= 0.4 && sliderValue <= 0.5) padding = 18;

    if (sliderValue >= 0.5) padding = 9;

    return padding;
  }

  TextStyle getTextStyle() {
    return GoogleFonts.getFont(
      fontFamily,
      textStyle: TextStyle(
        foreground:
            (outlineState == 0) ? null : Paint()
              ?..style = PaintingStyle.stroke
              ..strokeWidth = double.parse(outlineState.toString())
              ..color = textColor,
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

      default:
        return CrossAxisAlignment.center;
    }
  }
}
