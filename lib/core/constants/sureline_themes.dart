import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/theme/app_colors.dart';

class SurelineThemes {
  static final List<ThemeEntity> values = [
    ThemeEntity(
      textDecorEntity: App.themeEntity.textDecorEntity,
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
      textDecorEntity: App.themeEntity.textDecorEntity,
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
      textDecorEntity: App.themeEntity.textDecorEntity.copyWith(
        textColor: AppColors.pureWhite,
      ),
      backgroundEntity: ThemeBackgroundEntity(
        path: 'assets/videos/nature1.mp4',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: true,
        isLocallyStored: false,
      ),
      previewQuote: "Sureline",
    ),
    ThemeEntity(
      textDecorEntity: App.themeEntity.textDecorEntity.copyWith(
        textColor: AppColors.pureWhite,
      ),
      backgroundEntity: ThemeBackgroundEntity(
        path: 'assets/videos/nature2.mp4',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: true,
        isLocallyStored: false,
      ),
      previewQuote: "Sureline",
    ),
    ThemeEntity(
      textDecorEntity: App.themeEntity.textDecorEntity.copyWith(
        textColor: AppColors.pureWhite,
      ),
      backgroundEntity: ThemeBackgroundEntity(
        path: 'assets/videos/nature3.mp4',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: true,
        isLocallyStored: false,
      ),
      previewQuote: "Sureline",
    ),
    ThemeEntity(
      textDecorEntity: App.themeEntity.textDecorEntity.copyWith(
        textColor: AppColors.pureWhite,
      ),
      backgroundEntity: ThemeBackgroundEntity(
        path: 'assets/videos/sea.mp4',
        isNetwork: false,
        solidColor: null,
        isLiveBackground: true,
        isLocallyStored: false,
      ),
      previewQuote: "Sureline",
    ),
  ];
}
