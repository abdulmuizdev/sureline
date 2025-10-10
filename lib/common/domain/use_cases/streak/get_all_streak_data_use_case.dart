import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/streak/data/model/streak_model.dart';
import 'package:sureline/features/streak/domain/repository/streak_repository.dart';

/// Use case for getting all streak data.
///
/// This use case handles the business logic for retrieving
/// all streak-related data for the user.
class GetAllStreakDataUseCase {
  /// The streak repository dependency.
  final StreakRepository repository;

  /// Creates an instance of [GetAllStreakDataUseCase].
  const GetAllStreakDataUseCase(this.repository);

  /// Executes the use case to get all streak data.
  ///
  /// Returns [Either<Failure, List<StreakModel>>] containing streak data or failure.
  Either<Failure, List<StreakModel>> execute() {
    return repository.getAllStreakData();
  }
}
