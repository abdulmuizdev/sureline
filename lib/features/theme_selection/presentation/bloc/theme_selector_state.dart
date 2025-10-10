import 'package:sureline/common/domain/entities/create_theme_entity.dart';

/// Base class for all theme selector states.
/// All states that can be emitted by the ThemeSelectorBloc
/// must extend this class to ensure type safety.
abstract class ThemeSelectorState {
  const ThemeSelectorState();
}

/// Initial state when the theme selector feature is first loaded.
/// This state is emitted before any theme data is loaded or operations are performed.
class Initial extends ThemeSelectorState {}

/// State emitted while themes are being retrieved from the data source.
/// This state indicates that a loading operation is in progress.
class GettingThemes extends ThemeSelectorState {
  const GettingThemes();
}

/// State emitted when themes have been successfully retrieved.
/// This state contains the theme data and the currently active theme index.
///
/// [result] - The list of available themes
/// [activeIndex] - The index of the currently selected theme
class GotThemes extends ThemeSelectorState {
  /// The list of available themes retrieved from the data source.
  final List<ThemeEntity> result;

  /// The index of the currently active/selected theme.
  final int activeIndex;

  const GotThemes(this.result, this.activeIndex);
}

/// State emitted while theme mixes are being retrieved from the data source.
/// This state indicates that a loading operation for theme mixes is in progress.
class GettingThemeMixes extends ThemeSelectorState {
  const GettingThemeMixes();
}

/// State emitted when theme mixes have been successfully retrieved.
/// This state contains the theme mix data for display.
///
/// [result] - The list of available theme mixes
class GotThemeMixes extends ThemeSelectorState {
  /// The list of available theme mixes retrieved from the data source.
  final List<ThemeEntity> result;

  const GotThemeMixes(this.result);
}

/// State emitted when a theme change has been successfully completed.
/// This state indicates that the new theme has been applied throughout the app.
class ChangedTheme extends ThemeSelectorState {
  const ChangedTheme();
}

/// State emitted while a theme change operation is in progress.
/// This state indicates that the theme is currently being applied.
class ChangingTheme extends ThemeSelectorState {
  const ChangingTheme();
}
