import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/data/model/create_and_edit_theme_model.dart';
import 'package:uuid/uuid.dart';

class ThemeEntity extends Equatable {
  final String id;
  final DateTime lastAccessed;
  final String? previewQuote;
  final ThemeBackgroundEntity backgroundEntity;
  final ThemeTextDecorEntity textDecorEntity;
  final bool isActive;

  ThemeEntity({
    String? id,
    required this.lastAccessed,
    required this.textDecorEntity,
    required this.backgroundEntity,
    required this.previewQuote,
    this.isActive = false,
  }) : id = id ?? const Uuid().v4();

  @override
  List<Object?> get props => [previewQuote, backgroundEntity, textDecorEntity];

  factory ThemeEntity.fromModel(ThemeModel model) {
    return ThemeEntity(
      lastAccessed: model.lastAccessed,
      textDecorEntity: ThemeTextDecorEntity.fromModel(model.textDecorModel),
      backgroundEntity: ThemeBackgroundEntity.fromModel(model.backgroundModel),
      previewQuote: model.previewQuote,
      isActive: model.isActive,
    );
  }
}

class ThemeBackgroundEntity extends Equatable {
  final String? path;
  final String? previewImage;
  final Color? solidColor;
  final bool isNetwork;
  final bool isLocallyStored;
  final bool isLiveBackground;

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

class ThemeTextDecorEntity extends Equatable {
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final Color textColor;
  final TextAlign textAlign;
  final int outlineState;
  final double textPadding;

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
