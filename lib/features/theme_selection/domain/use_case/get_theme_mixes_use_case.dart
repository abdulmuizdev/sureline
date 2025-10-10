import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/theme_selection/domain/repository/theme_selector_repository.dart';

/// Use case for retrieving theme mixes from the repository.
///
/// This use case encapsulates the business logic for fetching predefined theme
/// combinations that provide curated visual experiences. It handles theme mix
/// retrieval operations and ensures proper error handling.
///
/// Key Features:
/// - Theme mix collection retrieval
/// - Curated theme combination access
/// - Business logic encapsulation
/// - Error handling and propagation
/// - Clean architecture compliance
///
/// Theme Mixes:
/// - Predefined theme combinations
/// - Curated visual experiences
/// - Enhanced user customization
/// - Professional theme collections
/// - Seasonal and special themes
///
/// Business Logic:
/// - Delegates to repository for data access
/// - Handles theme mix collection retrieval
/// - Manages error propagation
/// - Provides curated theme access
/// - Ensures data consistency
///
/// Usage Patterns:
/// - Curated theme collections
/// - Enhanced customization options
/// - Professional theme access
/// - Seasonal theme management
/// - Special event themes
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
class GetThemeMixesUseCase {
  /// Repository dependency for theme data access.
  /// Provides the data layer interface for theme mix operations.
  final ThemeSelectorRepository repository;

  /// Initializes the use case with the required repository dependency.
  ///
  /// [repository] - The theme selector repository for data access
  const GetThemeMixesUseCase(this.repository);

  /// Executes the use case to retrieve theme mixes.
  /// Delegates to the repository to fetch predefined theme combinations.
  ///
  /// Returns Either<Failure, List<ThemeEntity>> - Success with theme mixes or failure
  Future<Either<Failure, List<ThemeEntity>>> execute() {
    return repository.getThemesMixes();
  }
}
