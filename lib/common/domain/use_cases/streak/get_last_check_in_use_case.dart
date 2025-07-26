import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/streak/data/model/streak_model.dart';
import 'package:sureline/features/streak/domain/repository/streak_repository.dart';

/// Use case for getting the last check-in time.
///
/// This use case handles the business logic for retrieving
/// the user's most recent streak check-in.
class GetLastCheckInUseCase {
  /// The streak repository dependency.
  final StreakRepository repository;

  /// Creates an instance of [GetLastCheckInUseCase].
  const GetLastCheckInUseCase(this.repository);

  /// Executes the use case to get the last check-in.
  ///
  /// Returns [Either<Failure, StreakModel?>] containing the last check-in or failure.
  Either<Failure, StreakModel?> execute() {
    return repository.getLastCheckIn();
  }
}
