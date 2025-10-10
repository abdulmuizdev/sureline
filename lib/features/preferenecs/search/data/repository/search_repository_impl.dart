import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/search_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/search/data/data_source/search_data_source.dart';
import 'package:sureline/features/preferenecs/search/domain/repository/search_repository.dart';

/// Implementation of SearchRepository that coordinates search operations.
///
/// This class implements the SearchRepository interface and coordinates
/// between different data sources to provide comprehensive search results.
/// It follows Clean Architecture principles by implementing the repository
/// pattern and handling data mapping between layers.
///
/// Key Features:
/// - Repository pattern implementation
/// - Data source coordination
/// - Error handling and propagation
/// - Domain entity mapping
/// - Clean Architecture compliance
///
/// Data Coordination:
/// - Coordinates with SearchDataSource for quote retrieval
/// - Handles data mapping between data and domain layers
/// - Manages error propagation from data sources
/// - Provides unified interface for search operations
/// - Ensures data consistency across operations
///
/// Error Handling:
/// - Propagates errors from data sources
/// - Maps data layer errors to domain failures
/// - Maintains functional error handling patterns
/// - Provides meaningful error context
/// - Enables proper error recovery
///
/// Architecture Compliance:
/// - Implements repository interface contract
/// - Depends on data source abstraction
/// - Provides domain layer independence
/// - Supports dependency injection
/// - Enables testable implementation
///
/// Usage:
/// ```dart
/// final repository = SearchRepositoryImpl(searchDataSource);
/// final result = await repository.getSearch();
/// ```
class SearchRepositoryImpl implements SearchRepository {
  /// The data source for search operations.
  final SearchDataSource dataSource;

  /// Creates a new SearchRepositoryImpl instance.
  const SearchRepositoryImpl(this.dataSource);

  @override
  /// Retrieves search results by delegating to the data source.
  ///
  /// This method coordinates the search operation by delegating to the
  /// underlying data source and handling any data mapping or error
  /// propagation that may be required.
  ///
  /// Parameters:
  /// - [query]: The search query string
  /// - [isPremium]: Whether the user has premium access
  ///
  /// Returns:
  /// - [Either<Failure, List<SearchEntity>>] containing search results
  ///   or failure information from the data source
  ///
  /// Error Propagation:
  /// - Forwards data source errors to domain layer
  /// - Maintains error context and meaning
  /// - Enables proper error handling in use cases
  /// - Supports functional error handling patterns
  ///
  /// Success Flow:
  /// - Delegates search operation to data source
  /// - Returns search results directly from data source
  /// - Maintains data integrity and consistency
  /// - Provides ready-to-use domain entities
  Future<Either<Failure, List<SearchEntity>>> getSearch(String query, {required bool isPremium}) {
    return dataSource.getSearch(query, isPremium: isPremium);
  }
}
