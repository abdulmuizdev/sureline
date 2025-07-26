import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/data/model/theme_model.dart';
import 'package:sureline/features/theme_selection/data/data_source/theme_data_source.dart';
import 'package:sureline/features/theme_selection/domain/repository/theme_selector_repository.dart';

/// Implementation of the ThemeSelectorRepository interface.
///
/// This class provides the concrete implementation for theme data operations,
/// including data transformation between models and entities, theme persistence,
/// and global theme application. It handles the conversion between data models
/// and domain entities while ensuring proper separation of concerns.
///
/// Key Features:
/// - Data model to entity transformation
/// - Theme persistence and retrieval
/// - Global theme application
/// - Error handling and propagation
/// - Clean architecture compliance
///
/// Data Transformation:
/// - ThemeModel to ThemeEntity conversion
/// - Entity to model mapping
/// - Data consistency validation
/// - Type-safe transformations
/// - Performance-optimized operations
///
/// Theme Management:
/// - Theme collection retrieval
/// - Theme mix access
/// - Theme change operations
/// - Global theme synchronization
/// - Theme state persistence
///
/// Error Handling:
/// - Functional error handling with Either
/// - Proper error propagation
/// - Data validation
/// - Type-safe operations
/// - Consistent error patterns
///
/// The repository handles the conversion between data models and domain entities,
/// ensuring proper separation of concerns between layers.
class ThemeSelectorRepositoryImpl extends ThemeSelectorRepository {
  /// Data source dependency for theme data access.
  /// Provides the actual data retrieval and persistence functionality.
  final ThemeDataSource themeDataSource;

  /// Initializes the repository with the required data source dependency.
  ///
  /// [themeDataSource] - The theme data source for data operations
  ThemeSelectorRepositoryImpl(this.themeDataSource);

  /// Retrieves themes from data source and converts to domain entities.
  /// Handles data transformation and error propagation.
  ///
  /// Returns Either<Failure, List<ThemeEntity>> - Success with theme list or failure
  @override
  Future<Either<Failure, List<ThemeEntity>>> getThemes() async {
    final result = await themeDataSource.getThemes();
    return result.fold(
      (left) {
        return Left(left);
      },
      (right) {
        return Right(right.map((model) => ThemeEntity.fromModel(model)).toList());
      },
    );
  }

  /// Retrieves theme mixes from data source.
  /// Delegates to data source for curated theme collections.
  ///
  /// Returns Either<Failure, List<ThemeEntity>> - Success with theme mixes or failure
  @override
  Future<Either<Failure, List<ThemeEntity>>> getThemesMixes() {
    return themeDataSource.getThemesMixes();
  }

  /// Changes the current theme with data transformation.
  /// Converts entity to model and delegates to data source.
  ///
  /// [entity] - The theme entity to apply
  /// Returns Either<Failure, void> - Success or failure of theme change
  @override
  Future<Either<Failure, void>> changeTheme(ThemeEntity entity) {
    return themeDataSource.changeTheme(ThemeModel.fromEntity(entity));
  }

  /// Sets the current theme from stored preferences.
  /// Delegates to data source for theme application.
  ///
  /// Returns Either<Failure, void> - Success or failure of theme application
  @override
  Future<Either<Failure, void>> setTheme() {
    return themeDataSource.setTheme();
  }
}
