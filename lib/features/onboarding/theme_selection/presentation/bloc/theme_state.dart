
import 'package:sureline/common/domain/entities/create_theme_entity.dart';

abstract class ThemeState {
  const ThemeState();
}

class Initial extends ThemeState {
  const Initial();
}

class GettingThemes extends ThemeState {
  const GettingThemes();
}

class GotThemes extends ThemeState {
  final List<ThemeEntity> themes;
  const GotThemes(this.themes);
}