import 'package:sureline/common/domain/entities/create_theme_entity.dart';

/// Base class for all theme selection states during onboarding.
/// All states that can be emitted by the ThemeBloc
/// must extend this class to ensure type safety.
abstract class ThemeState {
  const ThemeState();
}

/// Initial state when the theme selection feature is first loaded.
/// This state is emitted before any theme data is loaded or operations are performed.
class Initial extends ThemeState {
  const Initial();
}

/// State emitted while themes are being retrieved from the data source.
/// This state indicates that a loading operation is in progress
/// and the UI should show appropriate loading indicators.
class GettingThemes extends ThemeState {
  const GettingThemes();
}

/// State emitted when themes have been successfully retrieved.
/// This state contains the theme data for the grid and the currently active theme index.
///
/// [themes] - The list of available themes for selection
/// [activeIndex] - The index of the currently selected theme in the list
class GotThemes extends ThemeState {
  /// The list of available themes retrieved from the data source.
  final List<ThemeEntity> themes;

  /// The index of the currently active/selected theme in the themes list.
  final int activeIndex;

  const GotThemes(this.themes, this.activeIndex);
}

/// State emitted when a theme change has been successfully completed.
/// This state indicates that the new theme has been applied throughout the app
/// and the selection has been updated in the UI.
class ChangedTheme extends ThemeState {
  const ChangedTheme();
}

/// State emitted while a theme change operation is in progress.
/// This state indicates that the theme is currently being applied
/// and the UI should show appropriate feedback.
class ChangingTheme extends ThemeState {
  const ChangingTheme();
}
