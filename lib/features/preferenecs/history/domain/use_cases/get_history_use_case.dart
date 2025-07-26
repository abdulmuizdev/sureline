import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/history_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/history/domain/repository/history_repository.dart';

/// Use case for retrieving all user's browsing history.
///
/// This use case encapsulates the business logic for fetching history
/// records from the data source. It follows the Clean Architecture
/// pattern by depending on the repository interface rather than
/// concrete implementations.
///
/// The use case returns an Either type for functional error handling,
/// where Left represents a failure and Right represents success with
/// the list of history entities.
class GetHistoryUseCase {
  final HistoryRepository historyRepository;

  /// Creates a new GetHistoryUseCase instance.
  ///
  /// [historyRepository] - The repository interface for history operations
  GetHistoryUseCase(this.historyRepository);

  /// Executes the use case to retrieve all history records.
  ///
  /// This method calls the repository to fetch all user's browsing
  /// history and returns the result wrapped in an Either type for
  /// proper error handling.
  ///
  /// [isPremium]: Whether the user has premium access
  /// Returns:
  /// - Left<Failure> - If the operation fails (database error, etc.)
  /// - Right<List<HistoryEntity>> - If the operation succeeds with the history list
  Future<Either<Failure, List<HistoryEntity>>> call({required bool isPremium}) async {
    return historyRepository.getHistory(isPremium: isPremium);
  }
}
