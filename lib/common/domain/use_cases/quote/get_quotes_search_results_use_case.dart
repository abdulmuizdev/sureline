import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';
import 'package:sureline/common/domain/entities/recommendation_algorithm/quote_entity.dart';

/// Use case for getting quote search results.
///
/// This use case handles the business logic for searching quotes
/// based on user queries with pagination support.
class GetQuotesSearchResultsUseCase {
  /// The quote repository dependency.
  final QuoteRepository repository;

  /// Creates an instance of [GetQuotesSearchResultsUseCase].
  const GetQuotesSearchResultsUseCase(this.repository);

  /// Executes the use case to get search results.
  ///
  /// Returns [Either<Failure, List<QuoteEntity>>] containing search results or failure.
  Future<Either<Failure, List<QuoteEntity>>> execute(String query, int page) {
    return repository.getQuotesSearchResults(query, page);
  }
}
