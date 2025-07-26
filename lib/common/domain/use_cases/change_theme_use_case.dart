/// Theme change use cases for the Sureline app.
///
/// This file contains the use case for handling theme changes
/// within the Sureline app. The [ChangeThemeUseCase] encapsulates
/// the business logic for changing the user's selected theme.
///
/// Key Features:
/// - Clean Architecture use case pattern
/// - Dependency injection with repository
/// - Functional error handling with Either
/// - Async operation support
///
/// Usage:
/// ```dart
/// final useCase = ChangeThemeUseCase(themeRepository);
/// final result = await useCase.execute(themeEntity);
/// result.fold(
///   (failure) => handleError(failure),
///   (_) => handleSuccess(),
/// );
/// ```

import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/theme_selection/domain/repository/theme_selector_repository.dart';

/// Use case for changing the application theme.
///
/// This use case handles the business logic for changing
/// the user's selected theme. It follows the Clean Architecture
/// pattern by encapsulating the business rules and delegating
/// data operations to the repository layer.
///
/// Responsibilities:
/// - Validate theme change requests
/// - Coordinate with theme repository
/// - Handle success and failure scenarios
/// - Provide clean interface for presentation layer
///
/// Dependencies:
/// - [ThemeSelectorRepository]: For theme data operations
///
/// Returns: [Either<Failure, void>] indicating success or failure
class ChangeThemeUseCase {
  /// The theme selector repository dependency.
  ///
  /// Used to perform theme-related data operations and persistence.
  final ThemeSelectorRepository repository;

  /// Creates an instance of [ChangeThemeUseCase].
  ///
  /// [repository]: The theme repository for data operations
  const ChangeThemeUseCase(this.repository);

  /// Executes the use case to change the theme.
  ///
  /// This method encapsulates the business logic for changing
  /// the user's selected theme. It delegates the actual theme
  /// change operation to the repository and returns a functional
  /// result indicating success or failure.
  ///
  /// [entity]: The theme entity to change to
  /// Returns: [Either<Failure, void>] indicating success or failure
  ///
  /// Example:
  /// ```dart
  /// final result = await useCase.execute(themeEntity);
  /// result.fold(
  ///   (failure) => print('Theme change failed: ${failure.message}'),
  ///   (_) => print('Theme changed successfully'),
  /// );
  /// ```
  Future<Either<Failure, void>> execute(ThemeEntity entity) async {
    return repository.changeTheme(entity);
  }
}
