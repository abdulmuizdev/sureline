import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/search_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/search/domain/repository/search_repository.dart';

/// Use case for retrieving search results from the quote database.
///
/// This use case encapsulates the business logic for searching quotes
/// and retrieving search results. It follows Clean Architecture principles
/// by depending on the repository interface and using functional error
/// handling with Either type for robust error management.
///
/// Key Features:
/// - Clean Architecture implementation
/// - Functional error handling with Either
/// - Repository pattern integration
/// - Business logic encapsulation
/// - Type-safe return values
///
/// Business Logic:
/// - Retrieves all available quotes for search
/// - Includes favorite status for each quote
/// - Associates quotes with their collections
/// - Provides comprehensive search metadata
/// - Handles search result formatting
///
/// Error Handling:
/// - Uses Either<Failure, List<SearchEntity>> for type safety
/// - Left represents failure cases (network, database, etc.)
/// - Right represents successful search results
/// - Enables functional error handling patterns
///
/// Usage:
/// ```dart
/// final result = await getSearchUseCase.call();
/// result.fold(
///   (failure) => handleError(failure),
///   (searchResults) => displayResults(searchResults),
/// );
/// ```
class GetSearchUseCase {
  /// The search repository dependency for data access.
  final SearchRepository repository;

  /// Creates a new GetSearchUseCase instance.
  const GetSearchUseCase(this.repository);

  /// Executes the use case to retrieve search results.
  ///
  /// This method performs the search operation by delegating to the
  /// repository layer. It returns an Either type that can represent
  /// either a failure or a list of search entities.
  ///
  /// Parameters:
  /// - [query]: The search query string
  /// - [isPremium]: Whether the user has premium access
  ///
  /// Returns:
  /// - [Either<Failure, List<SearchEntity>>] containing search results
  ///   or failure information
  ///
  /// Error Cases:
  /// - Database connection failures
  /// - Network connectivity issues
  /// - Data parsing errors
  /// - Repository operation failures
  ///
  /// Success Cases:
  /// - List of SearchEntity objects with quote data
  /// - Includes favorite status and collection associations
  /// - Ready for display in search UI
  Future<Either<Failure, List<SearchEntity>>> call(String query, {required bool isPremium}) {
    return repository.getSearch(query, isPremium: isPremium);
  }
}
