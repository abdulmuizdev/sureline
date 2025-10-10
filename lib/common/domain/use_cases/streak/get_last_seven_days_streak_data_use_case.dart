import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/streak_display_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/streak/domain/repository/streak_repository.dart';

/// Use case for getting the last seven days of streak data.
///
/// This use case handles the business logic for retrieving
/// streak data for the past week.
class GetLastSevenDaysStreakDataUseCase {
  /// The streak repository dependency.
  final StreakRepository repository;

  /// Creates an instance of [GetLastSevenDaysStreakDataUseCase].
  const GetLastSevenDaysStreakDataUseCase(this.repository);

  /// Executes the use case to get last seven days streak data.
  ///
  /// Returns [Either<Failure, List<StreakDisplayEntity>>] containing streak data or failure.
  Either<Failure, List<StreakDisplayEntity>> execute() {
    return repository.getLastSevenDaysStreakData();
  }
}
