import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/streak/domain/repository/streak_repository.dart';

/// Use case for getting the total streak score.
///
/// This use case handles the business logic for calculating
/// the user's total streak score.
class GetTotalStreakScoreUseCase {
  /// The streak repository dependency.
  final StreakRepository repository;

  /// Creates an instance of [GetTotalStreakScoreUseCase].
  const GetTotalStreakScoreUseCase(this.repository);

  /// Executes the use case to get total streak score.
  ///
  /// Returns [Either<Failure, int>] containing the total score or failure.
  Either<Failure, int> execute() {
    return repository.getTotalStreakScore();
  }
}
