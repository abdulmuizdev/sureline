import 'dart:ui';

import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/utils/utils.dart';

/// Model class for theme data.
class ThemeModel extends ThemeEntity {
  final ThemeTextDecorModel textDecorModel;
  final ThemeBackgroundModel backgroundModel;

  /// Creates a new ThemeModel instance.
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
  }) : super(textDecorEntity: textDecorModel, backgroundEntity: backgroundModel);

  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      textDecorModel: ThemeTextDecorModel.fromJson(json['textDecorEntity'] as Map<String, dynamic>),
      backgroundModel: ThemeBackgroundModel.fromJson(
        json['backgroundEntity'] as Map<String, dynamic>,
      ),
      lastAccessed: DateTime.parse(json['lastAccessed'] as String),
      previewQuote: json['previewQuote'] as String?,
      isActive: json['isActive'] as bool? ?? false,
      id: json['id'] as String?,
      isFree: json['isFree'] as bool? ?? false,
      isNew: json['isNew'] as bool? ?? false,
      isSeasonal: json['isSeasonal'] as bool? ?? false,
      isMostPopular: json['isMostPopular'] as bool? ?? false,
      isUserCreated: json['isUserCreated'] as bool? ?? false,
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
      'textDecorEntity': (ThemeTextDecorModel.fromEntity(textDecorEntity)).toJson(),
      'backgroundEntity': (ThemeBackgroundModel.fromEntity(backgroundEntity)).toJson(),
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

/// Model class for theme background data.
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
      path: json['path'] as String?,
      solidColor: (json['solidColor'] != null) ? Color(json['solidColor'] as int) : null,
      isNetwork: json['isNetwork'] as bool? ?? false,
      isLocallyStored: json['isLocallyStored'] as bool? ?? false,
      isLiveBackground: json['isLiveBackground'] as bool? ?? false,
      previewImage: json['previewImage'] as String?,
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

/// Model class for theme text decoration data.
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
      fontSize: (json['fontSize'] as num).toDouble(),
      fontWeight: FontWeight.values.firstWhere(
        (fw) => fw.value == json['fontWeight'] as int,
        orElse: () => FontWeight.normal,
      ),
      fontFamily: json['fontFamily'] as String,
      textAlign: TextAlign.values[json['textAlign'] as int],
      textColor: Color(json['textColor'] as int),
      outlineState: json['outlineState'] as int,
      textPadding: (json['textPadding'] as num).toDouble(),
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
