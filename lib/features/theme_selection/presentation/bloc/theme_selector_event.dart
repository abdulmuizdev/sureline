import 'package:sureline/common/domain/entities/create_theme_entity.dart';

/// Base class for all theme selector events.
/// All events that can be dispatched to the ThemeSelectorBloc
/// must extend this class to ensure type safety.
abstract class ThemeSelectorEvent {
  const ThemeSelectorEvent();
}

/// Event to retrieve all available themes.
/// This event triggers the loading of all theme options from the data source.
class GetThemes extends ThemeSelectorEvent {
  const GetThemes();
}

/// Event to retrieve free themes only.
/// This event filters and loads themes that are available without cost.
class GetFreeThemes extends ThemeSelectorEvent {
  const GetFreeThemes();
}

/// Event to retrieve new themes.
/// This event loads recently added or newly available theme options.
class GetNewThemes extends ThemeSelectorEvent {
  const GetNewThemes();
}

/// Event to retrieve seasonal themes.
/// This event loads themes that are specific to current seasons or holidays.
class GetSeasonalThemes extends ThemeSelectorEvent {
  const GetSeasonalThemes();
}

/// Event to retrieve most popular themes.
/// This event loads themes that are most frequently used or highly rated.
class GetMostPopularThemes extends ThemeSelectorEvent {
  const GetMostPopularThemes();
}

/// Event to retrieve recent themes.
/// This event loads themes that the user has recently accessed or used.
class GetRecentThemes extends ThemeSelectorEvent {
  const GetRecentThemes();
}

/// Event to retrieve theme mixes.
/// This event loads predefined theme combinations and curated collections.
class GetThemeMixes extends ThemeSelectorEvent {
  const GetThemeMixes();
}

/// Event to change the current theme.
/// This event triggers the application of a new theme throughout the app.
///
/// [entity] - The theme entity to apply as the current theme
class ChangeTheme extends ThemeSelectorEvent {
  /// The theme entity to be applied as the current theme.
  final ThemeEntity entity;

  const ChangeTheme(this.entity);
}
