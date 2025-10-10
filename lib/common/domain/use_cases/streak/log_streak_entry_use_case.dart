import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/streak/domain/repository/streak_repository.dart';

/// Use case for logging a streak entry.
///
/// This use case handles the business logic for recording
/// a new streak entry for the user.
class LogStreakEntryUseCase {
  /// The streak repository dependency.
  final StreakRepository repository;

  /// Creates an instance of [LogStreakEntryUseCase].
  const LogStreakEntryUseCase(this.repository);

  /// Executes the use case to log a streak entry.
  ///
  /// Returns [Either<Failure, void>] indicating success or failure.
  Future<Either<Failure, void>> execute() {
    return repository.logStreakEntry();
  }
}
