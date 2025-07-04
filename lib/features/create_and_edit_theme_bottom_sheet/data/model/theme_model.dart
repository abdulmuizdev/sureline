import 'dart:ui';

import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/utils/utils.dart';

class ThemeModel extends ThemeEntity {
  final ThemeTextDecorModel textDecorModel;
  final ThemeBackgroundModel backgroundModel;

  ThemeModel({
    required this.textDecorModel,
    required this.backgroundModel,
    required super.previewQuote,
    super.isActive,
    super.id,
    required super.lastAccessed,
    required super.isFree,
    required super.isNew,
    required super.isSeasonal,
    required super.isMostPopular,
    required super.isUserCreated,
  }) : super(
         textDecorEntity: textDecorModel,
         backgroundEntity: backgroundModel,
       );

  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      textDecorModel: ThemeTextDecorModel.fromJson(json['textDecorEntity']),
      backgroundModel: ThemeBackgroundModel.fromJson(json['backgroundEntity']),
      lastAccessed: DateTime.parse(json['lastAccessed']),
      previewQuote: json['previewQuote'],
      isActive: json['isActive'] ?? false,
      id: json['id'],
      isFree: json['isFree'] ?? false,
      isNew: json['isNew'] ?? false,
      isSeasonal: json['isSeasonal'] ?? false,
      isMostPopular: json['isMostPopular'] ?? false,
      isUserCreated: json['isUserCreated'] ?? false,
    );
  }

  factory ThemeModel.fromEntity(ThemeEntity entity) {
    return ThemeModel(
      lastAccessed: entity.lastAccessed,
      textDecorModel: ThemeTextDecorModel.fromEntity(entity.textDecorEntity),
      backgroundModel: ThemeBackgroundModel.fromEntity(entity.backgroundEntity),
      previewQuote: entity.previewQuote,
      isActive: entity.isActive,
      id: entity.id,
      isFree: entity.isFree,
      isNew: entity.isNew,
      isSeasonal: entity.isSeasonal,
      isMostPopular: entity.isMostPopular,
      isUserCreated: entity.isUserCreated,
    );
  }

  ThemeModel copyWith({
    ThemeTextDecorModel? textDecorModel,
    ThemeBackgroundModel? backgroundModel,
    String? previewQuote,
    bool? isActive,
    DateTime? lastAccessed,
    bool? isFree,
    bool? isNew,
    bool? isSeasonal,
    bool? isMostPopular,
    bool? isUserCreated,
  }) {
    return ThemeModel(
      lastAccessed: lastAccessed ?? this.lastAccessed,
      textDecorModel: textDecorModel ?? this.textDecorModel,
      backgroundModel: backgroundModel ?? this.backgroundModel,
      previewQuote: previewQuote ?? this.previewQuote,
      isActive: isActive ?? this.isActive,
      id: id,
      isFree: isFree ?? this.isFree,
      isNew: isNew ?? this.isNew,
      isSeasonal: isSeasonal ?? this.isSeasonal,
      isMostPopular: isMostPopular ?? this.isMostPopular,
      isUserCreated: isUserCreated ?? this.isUserCreated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'textDecorEntity':
          (ThemeTextDecorModel.fromEntity(textDecorEntity)).toJson(),
      'backgroundEntity':
          (ThemeBackgroundModel.fromEntity(backgroundEntity)).toJson(),
      'previewQuote': previewQuote,
      'isActive': isActive,
      'lastAccessed': lastAccessed.toIso8601String(),
      'id': id,
      'isFree': isFree,
      'isNew': isNew,
      'isSeasonal': isSeasonal,
      'isMostPopular': isMostPopular,
      'isUserCreated': isUserCreated,
    };
  }
}

class ThemeBackgroundModel extends ThemeBackgroundEntity {
  const ThemeBackgroundModel({
    required super.path,
    required super.isNetwork,
    required super.solidColor,
    required super.isLiveBackground,
    required super.isLocallyStored,
    required super.previewImage,
  });

  factory ThemeBackgroundModel.fromEntity(ThemeBackgroundEntity entity) {
    return ThemeBackgroundModel(
      path: entity.path,
      isNetwork: entity.isNetwork,
      solidColor: entity.solidColor,
      isLiveBackground: entity.isLiveBackground,
      isLocallyStored: entity.isLocallyStored,
      previewImage: entity.previewImage,
    );
  }

  factory ThemeBackgroundModel.fromJson(Map<String, dynamic> json) {
    return ThemeBackgroundModel(
      path: json['path'],
      solidColor:
          (json['solidColor'] != null) ? Color(json['solidColor']) : null,
      isNetwork: json['isNetwork'],
      isLocallyStored: json['isLocallyStored'],
      isLiveBackground: json['isLiveBackground'],
      previewImage: json['previewImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'isNetwork': isNetwork,
      'solidColor': solidColor?.value,
      'isLiveBackground': isLiveBackground,
      'isLocallyStored': isLocallyStored,
      'previewImage': previewImage,
    };
  }
}

class ThemeTextDecorModel extends ThemeTextDecorEntity {
  const ThemeTextDecorModel({
    required super.fontSize,
    required super.fontWeight,
    required super.fontFamily,
    required super.textAlign,
    required super.textColor,
    required super.outlineState,
    required super.textPadding,
  });

  factory ThemeTextDecorModel.fromEntity(ThemeTextDecorEntity entity) {
    return ThemeTextDecorModel(
      fontSize: entity.fontSize,
      fontWeight: entity.fontWeight,
      fontFamily: entity.fontFamily,
      textAlign: entity.textAlign,
      textColor: entity.textColor,
      outlineState: entity.outlineState,
      textPadding: entity.textPadding,
    );
  }

  factory ThemeTextDecorModel.fromJson(Map<String, dynamic> json) {
    return ThemeTextDecorModel(
      fontSize: json['fontSize'],
      fontWeight: FontWeight.values.firstWhere(
        (fw) => fw.value == json['fontWeight'],
        orElse: () => FontWeight.normal,
      ),
      fontFamily: json['fontFamily'],
      textAlign: TextAlign.values[json['textAlign']],
      textColor: Color(json['textColor']),
      outlineState: json['outlineState'],
      textPadding: json['textPadding'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fontSize': fontSize,
      'fontWeight': fontWeight.value,
      'fontFamily': fontFamily,
      'textAlign': textAlign.index,
      'textColor': textColor.value,
      'outlineState': outlineState,
      'textPadding': textPadding,
    };
  }
}
