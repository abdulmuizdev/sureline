import 'package:flutter/material.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:uuid/uuid.dart';

class SurelineThemes {
  static final List<ThemeEntity> values = [
    ThemeEntity(
      id: Uuid().v4(),
      lastAccessed: DateTime.now(),
      textDecorEntity: App.defaultTheme.textDecorEntity,
      backgroundEntity: ThemeBackgroundEntity(
        path: 'assets/images/background2.png',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: false,
        isLocallyStored: false,
      ),
      previewQuote: "Sureline",
    ),
    ThemeEntity(
      id: Uuid().v4(),
      lastAccessed: DateTime.now(),
      textDecorEntity: App.defaultTheme.textDecorEntity,
      backgroundEntity: ThemeBackgroundEntity(
        path: 'assets/images/background.png',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: false,
        isLocallyStored: false,
      ),
      previewQuote: "Sureline",
    ),
    ThemeEntity(
      id: Uuid().v4(),
      lastAccessed: DateTime.now(),
      textDecorEntity: App.defaultTheme.textDecorEntity.copyWith(
        textColor: AppColors.pureWhite,
      ),
      backgroundEntity: ThemeBackgroundEntity(
        path: 'assets/images/theme/leaves.jpg',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: false,
        isLocallyStored: false,
      ),
      previewQuote: "Sureline",
    ),
    ThemeEntity(
      id: Uuid().v4(),
      lastAccessed: DateTime.now(),
      textDecorEntity: App.defaultTheme.textDecorEntity.copyWith(
        textColor: AppColors.pureWhite,
      ),
      backgroundEntity: ThemeBackgroundEntity(
        path: 'assets/images/theme/nature.jpg',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: false,
        isLocallyStored: false,
      ),
      previewQuote: "Sureline",
    ),
    ThemeEntity(
      id: Uuid().v4(),
      lastAccessed: DateTime.now(),
      textDecorEntity: App.defaultTheme.textDecorEntity.copyWith(
        textColor: AppColors.pureWhite,
      ),
      backgroundEntity: ThemeBackgroundEntity(
        path: 'assets/images/theme/stars.jpg',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: false,
        isLocallyStored: false,
      ),
      previewQuote: "Sureline",
    ),
    ThemeEntity(
      id: Uuid().v4(),
      lastAccessed: DateTime.now(),
      textDecorEntity: App.defaultTheme.textDecorEntity.copyWith(
        textColor: AppColors.pureWhite,
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
      backgroundEntity: ThemeBackgroundEntity(
        path: 'assets/images/theme/sunset.jpg',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: false,
        isLocallyStored: false,
      ),
      previewQuote: "Sureline",
    ),

    ThemeEntity(
      id: Uuid().v4(),
      lastAccessed: DateTime.now(),
      textDecorEntity: App.defaultTheme.textDecorEntity.copyWith(
        textColor: AppColors.pureWhite,
      ),
      backgroundEntity: ThemeBackgroundEntity(
        path: 'assets/images/theme/dark_leaf.jpg',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: false,
        isLocallyStored: false,
      ),
      previewQuote: "Sureline",
    ),

    ThemeEntity(
      id: Uuid().v4(),
      lastAccessed: DateTime.now(),
      textDecorEntity: App.defaultTheme.textDecorEntity.copyWith(
        textColor: Color(0xFF333333),
        fontFamily: 'Playfair Display',
        fontSize: 26,
      ),
      backgroundEntity: ThemeBackgroundEntity(
        path: 'assets/images/theme/heaven.jpg',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: false,
        isLocallyStored: false,
      ),
      previewQuote: "Sureline",
    ),

    ThemeEntity(
      id: Uuid().v4(),
      lastAccessed: DateTime.now(),
      textDecorEntity: App.defaultTheme.textDecorEntity.copyWith(
        textColor: AppColors.pureWhite,
      ),
      backgroundEntity: ThemeBackgroundEntity(
        path: 'assets/images/theme/dark_rain.jpg',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: false,
        isLocallyStored: false,
      ),
      previewQuote: "Sureline",
    ),

    ThemeEntity(
      id: Uuid().v4(),
      lastAccessed: DateTime.now(),
      textDecorEntity: App.defaultTheme.textDecorEntity.copyWith(
        textColor: AppColors.pureWhite,
      ),
      backgroundEntity: ThemeBackgroundEntity(
        path: 'assets/images/theme/neon_rain.jpg',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: false,
        isLocallyStored: false,
      ),
      previewQuote: "Sureline",
    ),

    ThemeEntity(
      id: Uuid().v4(),
      lastAccessed: DateTime.now(),
      textDecorEntity: App.defaultTheme.textDecorEntity.copyWith(
        textColor: AppColors.pureWhite,
      ),
      backgroundEntity: ThemeBackgroundEntity(
        path: 'assets/images/theme/forest.jpg',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: false,
        isLocallyStored: false,
      ),
      previewQuote: "Sureline",
    ),

    // ThemeEntity(
    //   lastAccessed: DateTime.now(),
    //   textDecorEntity: App.themeEntity.textDecorEntity.copyWith(
    //     textColor: AppColors.pureWhite,
    //   ),
    //   backgroundEntity: ThemeBackgroundEntity(
    //     path: 'assets/videos/nature1.mp4',
    //     isNetwork: false,
    //     solidColor: null,
    //     isLiveBackground: true,
    //     isLocallyStored: false,
    //   ),
    //   previewQuote: "Sureline",
    // ),
    // ThemeEntity(
    //   lastAccessed: DateTime.now(),
    //   textDecorEntity: App.themeEntity.textDecorEntity.copyWith(
    //     textColor: AppColors.pureWhite,
    //   ),
    //   backgroundEntity: ThemeBackgroundEntity(
    //     path: 'assets/videos/nature2.mp4',
    //     isNetwork: false,
    //     solidColor: null,
    //     isLiveBackground: true,
    //     isLocallyStored: false,
    //   ),
    //   previewQuote: "Sureline",
    // ),
    // ThemeEntity(
    //   lastAccessed: DateTime.now(),
    //   textDecorEntity: App.themeEntity.textDecorEntity.copyWith(
    //     textColor: AppColors.pureWhite,
    //   ),
    //   backgroundEntity: ThemeBackgroundEntity(
    //     path: 'assets/videos/nature3.mp4',
    //     isNetwork: false,
    //     solidColor: null,
    //     isLiveBackground: true,
    //     isLocallyStored: false,
    //   ),
    //   previewQuote: "Sureline",
    // ),
    // ThemeEntity(
    //   lastAccessed: DateTime.now(),
    //   textDecorEntity: App.themeEntity.textDecorEntity.copyWith(
    //     textColor: AppColors.pureWhite,
    //   ),
    //   backgroundEntity: ThemeBackgroundEntity(
    //     path: 'assets/videos/sea.mp4',
    //     isNetwork: false,
    //     solidColor: null,
    //     isLiveBackground: true,
    //     isLocallyStored: false,
    //   ),
    //   previewQuote: "Sureline",
    // ),
  ];
}
