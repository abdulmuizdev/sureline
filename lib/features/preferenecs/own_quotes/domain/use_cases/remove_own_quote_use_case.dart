import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/repository/own_quotes_repository.dart';

/// Use case for removing an own quote.
///
/// This use case encapsulates the business logic for deleting a custom
/// quote created by the user. It follows the Clean Architecture pattern
/// by depending on the repository interface rather than concrete implementations.
///
/// The use case returns an Either type for functional error handling,
/// where Left represents a failure and Right represents success.
class RemoveOwnQuoteUseCase {
  final OwnQuotesRepository ownQuotesRepository;

  /// Creates a new RemoveOwnQuoteUseCase instance.
  ///
  /// [ownQuotesRepository] - The repository interface for own quotes operations
  RemoveOwnQuoteUseCase(this.ownQuotesRepository);

  /// Executes the use case to remove an own quote.
  ///
  /// This method calls the repository to delete the specified own quote
  /// and returns the result wrapped in an Either type for proper
  /// error handling.
  ///
  /// [id] - The ID of the own quote to be removed
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails (not found, database error, etc.)
  /// - Right<void> - If the own quote is successfully removed
  Future<Either<Failure, void>> call(int id) async {
    return await ownQuotesRepository.removeOwnQuote(id);
  }
}
