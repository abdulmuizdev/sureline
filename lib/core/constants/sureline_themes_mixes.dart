import 'package:flutter/material.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/theme/app_colors.dart';

class SurelineThemesMixes {
  static final List<ThemeEntity> values = [
    ThemeEntity(
      id: 'sureline-theme-2',
      lastAccessed: DateTime.now(),
      textDecorEntity: App.defaultTheme.textDecorEntity,
      backgroundEntity: ThemeBackgroundEntity(
        path: 'assets/images/background.png',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: false,
        isLocallyStored: false,
      ),
      previewQuote: "Plain",
      isFree: true,
      isNew: false,
      isSeasonal: false,
      isMostPopular: false,
    ),
    ThemeEntity(
      id: 'sureline-theme-3',
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
      previewQuote: "Nature",
      isFree: true,
      isNew: true,
      isSeasonal: false,
      isMostPopular: true,
    ),
    ThemeEntity(
      id: 'sureline-theme-6',
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
      previewQuote: "Seasonal",
      isFree: true,
      isNew: true,
      isSeasonal: true,
      isMostPopular: false,
    ),
    ThemeEntity(
      id: 'sureline-theme-8',
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
      previewQuote: "Most Popular",
      isFree: true,
      isNew: true,
      isSeasonal: false,
      isMostPopular: true,
    ),
    ThemeEntity(
      id: 'sureline-theme-9',
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
      previewQuote: "Rain",
      isFree: true,
      isNew: true,
      isSeasonal: false,
      isMostPopular: false,
    ),
  ];
}
