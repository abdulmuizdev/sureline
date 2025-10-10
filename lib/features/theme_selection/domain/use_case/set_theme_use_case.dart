import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/theme_selection/domain/repository/theme_selector_repository.dart';

/// Use case for setting the current theme based on stored preferences.
///
/// This use case encapsulates the business logic for applying the selected theme
/// throughout the app based on previously saved user preferences. It handles
/// theme application operations and ensures proper error handling.
///
/// Key Features:
/// - Theme application from stored preferences
/// - Global theme synchronization
/// - Business logic encapsulation
/// - Error handling and propagation
/// - Clean architecture compliance
///
/// Theme Application:
/// - Applies stored theme preferences
/// - Global theme synchronization
/// - Visual consistency maintenance
/// - User preference persistence
/// - Theme state management
///
/// Business Logic:
/// - Delegates to repository for data access
/// - Handles theme application logic
/// - Manages global theme state
/// - Provides theme persistence
/// - Ensures visual consistency
///
/// Usage Patterns:
/// - App startup theme loading
/// - Theme preference restoration
/// - Global theme synchronization
/// - User preference management
/// - Theme state persistence
///
/// Error Handling:
/// - Functional error handling with Either
/// - Proper error propagation
/// - Type-safe error management
/// - Domain-specific error handling
/// - Consistent error patterns
///
/// The use case follows the Either pattern for functional error handling,
/// ensuring proper error propagation and type safety.
class SetThemeUseCase {
  /// Repository dependency for theme data access.
  /// Provides the data layer interface for theme setting operations.
  final ThemeSelectorRepository repository;

  /// Initializes the use case with the required repository dependency.
  ///
  /// [repository] - The theme selector repository for data access
  const SetThemeUseCase(this.repository);

  /// Executes the use case to set the current theme.
  /// Delegates to the repository to apply the stored theme preferences.
  ///
  /// Returns Either<Failure, void> - Success or failure of theme application
  Future<Either<Failure, void>> execute() {
    return repository.setTheme();
  }
}
