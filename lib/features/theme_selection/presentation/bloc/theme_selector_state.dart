import 'package:sureline/common/domain/entities/create_theme_entity.dart';

abstract class ThemeSelectorState {
  const ThemeSelectorState();
}

class Initial extends ThemeSelectorState {}

class GettingThemes extends ThemeSelectorState {
  const GettingThemes();
}

class GotThemes extends ThemeSelectorState {
  final List<ThemeEntity> result;
  final int activeIndex;
  const GotThemes(this.result, this.activeIndex);
}

class GettingThemeMixes extends ThemeSelectorState {
  const GettingThemeMixes();
}

class GotThemeMixes extends ThemeSelectorState {
  final List<ThemeEntity> result;
  const GotThemeMixes(this.result);
}

class ChangedTheme extends ThemeSelectorState {
  const ChangedTheme();
}

class ChangingTheme extends ThemeSelectorState {
  const ChangingTheme();
}
