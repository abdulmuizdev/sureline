import 'package:sureline/common/domain/entities/create_theme_entity.dart';

abstract class ThemeSelectorEvent {
  const ThemeSelectorEvent();
}

class GetThemes extends ThemeSelectorEvent {
  const GetThemes();
}

class GetFreeThemes extends ThemeSelectorEvent {
  const GetFreeThemes();
}

class GetNewThemes extends ThemeSelectorEvent {
  const GetNewThemes();
}

class GetSeasonalThemes extends ThemeSelectorEvent {
  const GetSeasonalThemes();
}

class GetMostPopularThemes extends ThemeSelectorEvent {
  const GetMostPopularThemes();
}

class GetRecentThemes extends ThemeSelectorEvent {
  const GetRecentThemes();
}

class GetThemeMixes extends ThemeSelectorEvent {
  const GetThemeMixes();
}

class ChangeTheme extends ThemeSelectorEvent {
  final ThemeEntity entity;
  const ChangeTheme(this.entity);
}
