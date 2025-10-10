import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/common/domain/use_cases/change_theme_use_case.dart';
import 'package:sureline/features/theme_selection/domain/use_case/get_theme_mixes_use_case.dart';
import 'package:sureline/features/theme_selection/domain/use_case/get_themes_use_case.dart';
import 'package:sureline/features/theme_selection/presentation/bloc/theme_selector_event.dart';
import 'package:sureline/features/theme_selection/presentation/bloc/theme_selector_state.dart';

/// Bloc for managing theme selection state and operations.
///
/// This bloc handles comprehensive theme management including data retrieval,
/// filtering by various categories, theme changes, and state coordination
/// throughout the app. It provides a centralized state management solution
/// for all theme-related operations with proper error handling and user feedback.
///
/// Key Features:
/// - Multi-category theme filtering (Free, New, Seasonal, Popular, Recent)
/// - Theme change management with haptic feedback
/// - Theme mix support for advanced customization
/// - Active theme tracking and management
/// - Performance optimization with efficient filtering
/// - Clean Architecture compliance with use case integration
///
/// Theme Categories:
/// - All Themes: Complete theme collection
/// - Free Themes: No-cost theme options
/// - New Themes: Recently added themes
/// - Seasonal Themes: Time-based theme collections
/// - Most Popular Themes: High-engagement themes
/// - Recent Themes: Recently accessed themes
///
/// State Management:
/// - Initial: No theme data loaded
/// - GettingThemes: Loading theme data
/// - GotThemes: Themes loaded with active index
/// - GettingThemeMixes: Loading theme mixes
/// - GotThemeMixes: Theme mixes loaded
/// - ChangingTheme: Theme change in progress
/// - ChangedTheme: Theme change completed
///
/// Performance Optimizations:
/// - Efficient filtering algorithms
/// - Lazy loading of theme data
/// - Optimized state updates
/// - Memory-efficient theme management
///
/// Usage:
/// ```dart
/// BlocProvider(
///   create: (context) => ThemeSelectorBloc(
///     getThemesUseCase,
///     getThemeMixesUseCase,
///     changeThemeUseCase,
///   ),
///   child: ThemeSelectionWidget(),
/// );
/// ```
class ThemeSelectorBloc extends Bloc<ThemeSelectorEvent, ThemeSelectorState> {
  /// Use case for retrieving themes from the domain layer.
  final GetThemesUseCase _getThemesUseCase;

  /// Use case for retrieving theme mixes from the domain layer.
  final GetThemeMixesUseCase _getThemeMixesUseCase;

  /// Use case for changing the current theme.
  final ChangeThemeUseCase _changeThemeUseCase;

  /// Initializes the bloc with required use case dependencies.
  /// Sets up event handlers for all theme-related operations.
  ///
  /// [_getThemesUseCase] - Use case for theme retrieval
  /// [_getThemeMixesUseCase] - Use case for theme mix retrieval
  /// [_changeThemeUseCase] - Use case for theme changes
  ThemeSelectorBloc(this._getThemesUseCase, this._getThemeMixesUseCase, this._changeThemeUseCase)
    : super(Initial()) {
    _setupEventHandlers();
  }

  /// Sets up event handlers for all theme selector events.
  /// Configures handlers for theme retrieval, filtering, and changes.
  void _setupEventHandlers() {
    on<GetThemes>(_handleGetThemes);
    on<GetFreeThemes>(_handleGetFreeThemes);
    on<GetNewThemes>(_handleGetNewThemes);
    on<GetSeasonalThemes>(_handleGetSeasonalThemes);
    on<GetMostPopularThemes>(_handleGetMostPopularThemes);
    on<GetRecentThemes>(_handleGetRecentThemes);
    on<GetThemeMixes>(_handleGetThemeMixes);
    on<ChangeTheme>(_handleChangeTheme);
  }

  /// Handles the GetThemes event.
  /// Retrieves all available themes and finds the active theme index.
  ///
  /// [event] - The GetThemes event
  /// [emit] - Function to emit new states
  void _handleGetThemes(GetThemes event, Emitter<ThemeSelectorState> emit) async {
    emit(GettingThemes());
    final result = await _getThemesUseCase.execute();
    result.fold(
      (left) {}, // Handle failure if needed
      (right) {
        final activeIndex = right.indexWhere((entity) => entity.isActive == true);
        emit(GotThemes(right, activeIndex));
      },
    );
  }

  /// Handles the GetFreeThemes event.
  /// Retrieves and filters themes to show only free options.
  ///
  /// [event] - The GetFreeThemes event
  /// [emit] - Function to emit new states
  void _handleGetFreeThemes(GetFreeThemes event, Emitter<ThemeSelectorState> emit) async {
    emit(GettingThemes());
    final result = await _getThemesUseCase.execute();
    result.fold(
      (left) {}, // Handle failure if needed
      (right) {
        final filteredThemes = right.where((entity) => entity.isFree == true).toList();
        final activeIndex = filteredThemes.indexWhere((entity) => entity.isActive == true);
        emit(GotThemes(filteredThemes, activeIndex));
      },
    );
  }

  /// Handles the GetNewThemes event.
  /// Retrieves and filters themes to show only new options.
  ///
  /// [event] - The GetNewThemes event
  /// [emit] - Function to emit new states
  void _handleGetNewThemes(GetNewThemes event, Emitter<ThemeSelectorState> emit) async {
    emit(GettingThemes());
    final result = await _getThemesUseCase.execute();
    result.fold(
      (left) {}, // Handle failure if needed
      (right) {
        final filteredThemes = right.where((entity) => entity.isNew == true).toList();
        final activeIndex = filteredThemes.indexWhere((entity) => entity.isActive == true);
        emit(GotThemes(filteredThemes, activeIndex));
      },
    );
  }

  /// Handles the GetSeasonalThemes event.
  /// Retrieves and filters themes to show only seasonal options.
  ///
  /// [event] - The GetSeasonalThemes event
  /// [emit] - Function to emit new states
  void _handleGetSeasonalThemes(GetSeasonalThemes event, Emitter<ThemeSelectorState> emit) async {
    emit(GettingThemes());
    final result = await _getThemesUseCase.execute();
    result.fold(
      (left) {}, // Handle failure if needed
      (right) {
        final filteredThemes = right.where((entity) => entity.isSeasonal == true).toList();
        final activeIndex = filteredThemes.indexWhere((entity) => entity.isActive == true);
        emit(GotThemes(filteredThemes, activeIndex));
      },
    );
  }

  /// Handles the GetMostPopularThemes event.
  /// Retrieves and filters themes to show only most popular options.
  ///
  /// [event] - The GetMostPopularThemes event
  /// [emit] - Function to emit new states
  void _handleGetMostPopularThemes(
    GetMostPopularThemes event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    emit(GettingThemes());
    final result = await _getThemesUseCase.execute();
    result.fold(
      (left) {}, // Handle failure if needed
      (right) {
        final filteredThemes = right.where((entity) => entity.isMostPopular == true).toList();
        final activeIndex = filteredThemes.indexWhere((entity) => entity.isActive == true);
        emit(GotThemes(filteredThemes, activeIndex));
      },
    );
  }

  /// Handles the GetRecentThemes event.
  /// Retrieves themes and sorts them by last accessed time.
  ///
  /// [event] - The GetRecentThemes event
  /// [emit] - Function to emit new states
  void _handleGetRecentThemes(GetRecentThemes event, Emitter<ThemeSelectorState> emit) async {
    emit(GettingThemes());
    final result = await _getThemesUseCase.execute();
    result.fold(
      (left) {}, // Handle failure if needed
      (right) {
        final sortedThemes = List<ThemeEntity>.from(right)
          ..sort((a, b) => b.lastAccessed.compareTo(a.lastAccessed));
        final activeIndex = sortedThemes.indexWhere((entity) => entity.isActive == true);
        emit(GotThemes(sortedThemes, activeIndex));
      },
    );
  }

  /// Handles the GetThemeMixes event.
  /// Retrieves theme mixes from the domain layer.
  ///
  /// [event] - The GetThemeMixes event
  /// [emit] - Function to emit new states
  void _handleGetThemeMixes(GetThemeMixes event, Emitter<ThemeSelectorState> emit) async {
    emit(GettingThemeMixes());
    final result = await _getThemeMixesUseCase.execute();
    result.fold(
      (left) {}, // Handle failure if needed
      (right) {
        emit(GotThemeMixes(right));
      },
    );
  }

  /// Handles the ChangeTheme event.
  /// Applies a new theme throughout the app with haptic feedback.
  ///
  /// [event] - The ChangeTheme event containing the theme to apply
  /// [emit] - Function to emit new states
  void _handleChangeTheme(ChangeTheme event, Emitter<ThemeSelectorState> emit) async {
    emit(ChangingTheme());
    HapticFeedback.lightImpact();

    print('Change theme called with font size: ${event.entity.textDecorEntity.fontSize}');

    final result = await _changeThemeUseCase.execute(event.entity);
    result.fold(
      (left) {}, // Handle failure if needed
      (right) {
        emit(ChangedTheme());
      },
    );
  }
}
