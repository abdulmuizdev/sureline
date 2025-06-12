
import 'package:sureline/common/domain/entities/create_theme_entity.dart';

abstract class ThemeSelectorEvent {
  const ThemeSelectorEvent();
}

class GetThemes extends ThemeSelectorEvent {
  const GetThemes();
}

class GetThemeMixes extends ThemeSelectorEvent {
  const GetThemeMixes();
}

class ChangeTheme extends ThemeSelectorEvent {
  final ThemeEntity entity;
  const ChangeTheme(this.entity);
}