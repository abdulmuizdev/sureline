import 'package:sureline/common/domain/entities/create_theme_entity.dart';

/// Base class for all theme selection events during onboarding.
/// All events that can be dispatched to the ThemeBloc
/// must extend this class to ensure type safety.
abstract class ThemeEvent {
  const ThemeEvent();
}

/// Event to retrieve available themes for the onboarding theme selection.
/// This event triggers the loading of theme data from the data source
/// to populate the theme selection grid.
class GetThemes extends ThemeEvent {
  const GetThemes();
}

/// Event to change the currently selected theme during onboarding.
/// This event triggers the application of a new theme and updates
/// the selection state in the UI.
///
/// [entity] - The theme entity to be applied as the selected theme
class ChangeTheme extends ThemeEvent {
  /// The theme entity to be applied as the selected theme.
  final ThemeEntity entity;

  const ChangeTheme(this.entity);
}
