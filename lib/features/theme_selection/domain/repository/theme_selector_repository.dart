import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/error/failures.dart';

/// Repository interface for theme selection and management.
///
/// This repository provides comprehensive theme management functionality including
/// theme retrieval, theme mixes, theme changes, and global theme application.
/// It follows the Either pattern for functional error handling and ensures proper
/// separation between domain and data layers.
///
/// Key Features:
/// - Theme collection management and retrieval
/// - Theme mix (curated combinations) support
/// - Theme change operations with persistence
/// - Global theme application throughout app
/// - Theme categorization and filtering
/// - Performance-optimized theme operations
///
/// Theme Management:
/// - Individual theme retrieval and application
/// - Theme mix collections for curated experiences
/// - Theme persistence and state management
/// - Global theme synchronization
/// - Theme categorization (Free, New, Seasonal, Popular)
///
/// Data Operations:
/// - Local storage for theme persistence
/// - Theme state synchronization
/// - Efficient theme retrieval and caching
/// - Theme change validation and application
/// - Performance-optimized theme operations
///
/// Theme Categories:
/// - All Themes: Complete theme collection
/// - Free Themes: No-cost theme options
/// - New Themes: Recently added themes
/// - Seasonal Themes: Time-based collections
/// - Most Popular Themes: High-engagement themes
/// - Recent Themes: Recently accessed themes
/// - Theme Mixes: Curated combinations
///
/// State Management:
/// - Active theme tracking
/// - Theme change coordination
/// - Global state synchronization
/// - Persistence layer integration
/// - Error handling and recovery
abstract class ThemeSelectorRepository {
  /// Retrieves the list of available themes from the data source.
  /// Returns a comprehensive list of all theme options with metadata.
  ///
  /// Returns Either<Failure, List<ThemeEntity>> - Success with theme list or failure
  Future<Either<Failure, List<ThemeEntity>>> getThemes();

  /// Retrieves the list of theme mixes (predefined theme combinations).
  /// Returns curated theme collections for enhanced user experience.
  ///
  /// Returns Either<Failure, List<ThemeEntity>> - Success with theme mixes or failure
  Future<Either<Failure, List<ThemeEntity>>> getThemesMixes();

  /// Changes the current theme to the specified theme entity.
  /// Persists the theme selection and applies it throughout the app.
  ///
  /// [entity] - The ThemeEntity to set as the current theme
  /// Returns Either<Failure, void> - Success or failure of theme change
  Future<Either<Failure, void>> changeTheme(ThemeEntity entity);

  /// Sets the current theme based on stored preferences.
  /// Applies the previously selected theme to the app on startup.
  ///
  /// Returns Either<Failure, void> - Success or failure of theme application
  Future<Either<Failure, void>> setTheme();
}
