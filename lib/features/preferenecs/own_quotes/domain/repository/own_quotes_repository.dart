import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/own_quote_entity.dart';
import 'package:sureline/core/error/failures.dart';

/// Abstract repository interface for own quotes operations.
///
/// This repository defines the contract for all own quotes-related data
/// operations, including retrieving, adding, and removing custom quotes
/// created by the user. It follows the Clean Architecture pattern by
/// providing a clean interface that the domain layer depends on.
///
/// The repository handles the persistence and retrieval of user's custom
/// quotes, which are quotes that users create themselves rather than
/// quotes from the app's content library.
abstract class OwnQuotesRepository {
  /// Retrieves all own quotes for the current user.
  ///
  /// This method fetches all custom quotes that the user has created
  /// and returns them as a list of OwnQuoteEntity objects.
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails (database error, etc.)
  /// - Right<List<OwnQuoteEntity>> - If the operation succeeds with the own quotes list
  Future<Either<Failure, List<OwnQuoteEntity>>> getAllOwnQuotes();

  /// Adds a new own quote to the user's collection.
  ///
  /// This method saves a new custom quote created by the user
  /// to the data source for future retrieval.
  ///
  /// [ownQuote] - The own quote entity to be saved
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails (validation error, storage error, etc.)
  /// - Right<void> - If the own quote is successfully saved
  Future<Either<Failure, void>> addOwnQuote(OwnQuoteEntity ownQuote);

  /// Removes an own quote from the user's collection.
  ///
  /// This method deletes a custom quote from the user's collection
  /// based on its unique identifier.
  ///
  /// [id] - The unique identifier of the own quote to be removed
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails (not found, database error, etc.)
  /// - Right<void> - If the own quote is successfully removed
  Future<Either<Failure, void>> removeOwnQuote(int id);
}
