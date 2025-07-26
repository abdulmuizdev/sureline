import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/streak/domain/repository/streak_repository.dart';

/// Use case for clearing streak data.
///
/// This use case handles the business logic for clearing
/// all streak-related data for the user.
class ClearStreakDataUseCase {
  /// The streak repository dependency.
  final StreakRepository repository;

  /// Creates an instance of [ClearStreakDataUseCase].
  const ClearStreakDataUseCase(this.repository);

  /// Executes the use case to clear streak data.
  ///
  /// Returns [Either<Failure, void>] indicating success or failure.
  Future<Either<Failure, void>> execute() {
    return repository.clearStreakData();
  }
}
