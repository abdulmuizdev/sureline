import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/search_entity.dart';
import 'package:sureline/core/error/failures.dart';

/// Abstract repository interface for search operations.
///
/// This interface defines the contract for search-related data operations
/// following Clean Architecture principles. It provides a clean abstraction
/// for the domain layer to access search data without depending on
/// specific data source implementations.
///
/// Key Features:
/// - Clean Architecture abstraction layer
/// - Functional error handling with Either
/// - Domain entity integration
/// - Repository pattern implementation
/// - Type-safe method signatures
///
/// Architecture Role:
/// - Acts as boundary between domain and data layers
/// - Enables dependency inversion principle
/// - Provides testable interface for domain logic
/// - Supports multiple data source implementations
/// - Maintains domain layer independence
///
/// Data Operations:
/// - Retrieves search results from data sources
/// - Handles quote search and filtering
/// - Manages favorite status integration
/// - Provides collection association data
/// - Supports search result formatting
///
/// Error Handling:
/// - Uses Either<Failure, List<SearchEntity>> pattern
/// - Left represents various failure scenarios
/// - Right represents successful search results
/// - Enables functional error handling in domain layer
///
/// Implementation Requirements:
/// - Concrete implementations must handle data source coordination
/// - Database operations for quote retrieval
/// - Favorite status checking and integration
/// - Collection association management
/// - Error mapping and propagation
///
/// Usage:
/// ```dart
/// class SearchRepositoryImpl implements SearchRepository {
///   @override
///   Future<Either<Failure, List<SearchEntity>>> getSearch() {
///     // Implementation details
///   }
/// }
/// ```
abstract class SearchRepository {
  /// Retrieves search results from the data source.
  ///
  /// This method performs the search operation by delegating to the
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
  Future<Either<Failure, List<SearchEntity>>> getSearch(String query, {required bool isPremium});
}
