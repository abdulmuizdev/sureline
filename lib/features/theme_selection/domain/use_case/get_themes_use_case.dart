import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/theme_selection/domain/repository/theme_selector_repository.dart';

/// Use case for retrieving available themes from the repository.
///
/// This use case encapsulates the business logic for fetching theme data and provides
/// a clean interface for the presentation layer. It handles theme retrieval operations
/// and ensures proper error handling throughout the domain layer.
///
/// Key Features:
/// - Theme data retrieval from repository
/// - Business logic encapsulation
/// - Error handling and propagation
/// - Clean architecture compliance
/// - Type-safe operations
///
/// Business Logic:
/// - Delegates to repository for data access
/// - Handles theme collection retrieval
/// - Manages error propagation
/// - Provides domain-specific operations
/// - Ensures data consistency
///
/// Usage Patterns:
/// - Presentation layer integration
/// - Theme management workflows
/// - Error handling coordination
/// - State management support
/// - Clean architecture compliance
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
class GetThemesUseCase {
  /// Repository dependency for theme data access.
  /// Provides the data layer interface for theme operations.
  final ThemeSelectorRepository repository;

  /// Initializes the use case with the required repository dependency.
  ///
  /// [repository] - The theme selector repository for data access
  const GetThemesUseCase(this.repository);

  /// Executes the use case to retrieve available themes.
  /// Delegates to the repository to fetch theme data from the data source.
  ///
  /// Returns Either<Failure, List<ThemeEntity>> - Success with theme list or failure
  Future<Either<Failure, List<ThemeEntity>>> execute() {
    return repository.getThemes();
  }
}
