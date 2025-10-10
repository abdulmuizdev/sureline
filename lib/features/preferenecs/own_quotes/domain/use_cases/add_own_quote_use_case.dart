import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/own_quote_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/repository/own_quotes_repository.dart';

/// Use case for adding a new own quote.
///
/// This use case encapsulates the business logic for saving a new custom
/// quote created by the user. It follows the Clean Architecture pattern
/// by depending on the repository interface rather than concrete implementations.
///
/// The use case returns an Either type for functional error handling,
/// where Left represents a failure and Right represents success.
class AddOwnQuoteUseCase {
  final OwnQuotesRepository ownQuotesRepository;

  /// Creates a new AddOwnQuoteUseCase instance.
  ///
  /// [ownQuotesRepository] - The repository interface for own quotes operations
  AddOwnQuoteUseCase(this.ownQuotesRepository);

  /// Executes the use case to add a new own quote.
  ///
  /// This method calls the repository to save the new custom quote
  /// and returns the result wrapped in an Either type for proper
  /// error handling.
  ///
  /// [ownQuote] - The own quote entity to be saved
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails (validation error, storage error, etc.)
  /// - Right<void> - If the own quote is successfully saved
  Future<Either<Failure, void>> call(OwnQuoteEntity ownQuote) async {
    return await ownQuotesRepository.addOwnQuote(ownQuote);
  }
}
