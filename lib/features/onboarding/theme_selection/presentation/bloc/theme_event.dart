import 'package:sureline/common/domain/entities/create_theme_entity.dart';

abstract class ThemeEvent {
  const ThemeEvent();
}

class GetThemes extends ThemeEvent {
  const GetThemes();
}

class ChangeTheme extends ThemeEvent {
  final ThemeEntity entity;
  const ChangeTheme(this.entity);
}
