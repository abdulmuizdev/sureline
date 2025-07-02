import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/constants/constants.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/remote_config/domain/entities/remote_config_entity.dart';
import 'package:uuid/uuid.dart';

class App {
  static double volume = Constants.defaultVolume;
  static Map<String, String>? voice;
  static RemoteConfigEntity remoteConfigEntity = Constants.remoteConfigModel;
  static ValueKey homeScreenQuoteKey = ValueKey('quote_0');
  static ThemeEntity defaultTheme = ThemeEntity(
    id: Uuid().v4(),
    lastAccessed: DateTime.now(),
    textDecorEntity: ThemeTextDecorEntity(
      fontSize: Constants.defaultFontSize,
      fontWeight: Constants.defaultFontWeight,
      fontFamily: Constants.defaultFontFamily,
      textAlign: TextAlign.center,
      textColor: AppColors.primaryColor,
      outlineState: 0,
      textPadding: 18,
    ),
    backgroundEntity: ThemeBackgroundEntity(
      path: Constants.defaultBackground,
      isNetwork: false,
      solidColor: null,
      isLiveBackground: false,
      isLocallyStored: false,
    ),
    previewQuote: null,
    isFree: false,
    isNew: false,
    isSeasonal: false,
    isMostPopular: false,
  );
  static ThemeEntity themeEntity = defaultTheme;

  static Color homeActionColor = AppColors.primaryColor;
  static Color homeButtonColor = AppColors.pureWhite;

  static Color? bgSolidColor;
}
