import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/use_cases/change_theme_use_case.dart';
import 'package:sureline/features/onboarding/theme_selection/presentation/bloc/theme_event.dart';
import 'package:sureline/features/onboarding/theme_selection/presentation/bloc/theme_state.dart';
import 'package:sureline/features/theme_selection/domain/use_case/get_themes_use_case.dart';

/// Bloc for managing theme selection state during the onboarding process.
/// This bloc handles theme data retrieval and theme changes specifically
/// for the onboarding theme selection screen.
///
/// The bloc coordinates between the UI and domain layer, providing
/// proper state management for theme operations during onboarding.
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  /// Use case for changing the current theme throughout the app.
  final ChangeThemeUseCase _changeThemeUseCase;

  /// Use case for retrieving available themes from the domain layer.
  final GetThemesUseCase _getThemesUseCase;

  /// Initializes the bloc with required use case dependencies.
  /// Sets up event handlers for theme retrieval and changes.
  ///
  /// [_changeThemeUseCase] - Use case for theme changes
  /// [_getThemesUseCase] - Use case for theme retrieval
  ThemeBloc(this._changeThemeUseCase, this._getThemesUseCase) : super(Initial()) {
    _setupEventHandlers();
  }

  /// Sets up event handlers for all theme selection events.
  /// Configures handlers for theme retrieval and changes.
  void _setupEventHandlers() {
    on<GetThemes>(_handleGetThemes);
    on<ChangeTheme>(_handleChangeTheme);
  }

  /// Handles the GetThemes event.
  /// Retrieves available themes and finds the active theme index.
  /// Reverses the theme list for display order and emits GotThemes state.
  ///
  /// [event] - The GetThemes event
  /// [emit] - Function to emit new states
  void _handleGetThemes(GetThemes event, Emitter<ThemeState> emit) async {
    final result = await _getThemesUseCase.execute();
    result.fold(
      (left) {}, // Handle failure if needed
      (right) {
        final reversedThemes = right.reversed.toList();
        final activeIndex = reversedThemes.indexWhere((theme) => theme.isActive);
        emit(GotThemes(reversedThemes, activeIndex));
      },
    );
  }

  /// Handles the ChangeTheme event.
  /// Applies a new theme throughout the app with haptic feedback.
  /// After successful theme change, refreshes the theme list.
  ///
  /// [event] - The ChangeTheme event containing the theme to apply
  /// [emit] - Function to emit new states
  void _handleChangeTheme(ChangeTheme event, Emitter<ThemeState> emit) async {
    emit(ChangingTheme());
    HapticFeedback.lightImpact();

    final result = await _changeThemeUseCase.execute(event.entity);
    result.fold(
      (left) {}, // Handle failure if needed
      (right) {
        // Refresh themes after successful change
        add(GetThemes());
      },
    );
  }
}
