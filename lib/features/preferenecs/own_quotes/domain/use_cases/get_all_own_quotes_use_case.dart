import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/own_quote_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/repository/own_quotes_repository.dart';

/// Use case for retrieving all user's own quotes.
///
/// This use case encapsulates the business logic for fetching all custom
/// quotes created by the user. It follows the Clean Architecture pattern
/// by depending on the repository interface rather than concrete implementations.
///
/// The use case returns an Either type for functional error handling,
/// where Left represents a failure and Right represents success with the
/// list of own quote entities.
class GetAllOwnQuotesUseCase {
  final OwnQuotesRepository ownQuotesRepository;

  /// Creates a new GetAllOwnQuotesUseCase instance.
  ///
  /// [ownQuotesRepository] - The repository interface for own quotes operations
  GetAllOwnQuotesUseCase(this.ownQuotesRepository);

  /// Executes the use case to retrieve all own quotes.
  ///
  /// This method calls the repository to fetch all custom quotes
  /// created by the user and returns the result wrapped in an Either
  /// type for proper error handling.
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails (database error, etc.)
  /// - Right<List<OwnQuoteEntity>> - If the operation succeeds with the own quotes list
  Future<Either<Failure, List<OwnQuoteEntity>>> call() async {
    return await ownQuotesRepository.getAllOwnQuotes();
  }
}
