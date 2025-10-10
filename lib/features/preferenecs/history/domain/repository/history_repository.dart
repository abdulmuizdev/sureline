import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/history_entity.dart';
import 'package:sureline/core/error/failures.dart';

/// Abstract repository interface for history operations.
///
/// This repository defines the contract for all history-related data
/// operations, including retrieving browsing history records. It follows
/// the Clean Architecture pattern by providing a clean interface that
/// the domain layer depends on.
///
/// The repository handles the persistence and retrieval of user's
/// browsing history, which tracks quotes that the user has viewed
/// during their app usage.
abstract class HistoryRepository {
  /// Retrieves all browsing history records for the current user.
  ///
  /// This method fetches all history records that track the user's
  /// browsing activity, including quotes they have viewed and their
  /// interaction status (favourited, etc.).
  ///
  /// [isPremium]: Whether the user has premium access
  /// Returns:
  /// - Left<Failure> - If the operation fails (database error, etc.)
  /// - Right<List<HistoryEntity>> - If the operation succeeds with the history list
  Future<Either<Failure, List<HistoryEntity>>> getHistory({required bool isPremium});
}
