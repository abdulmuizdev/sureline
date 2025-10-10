import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/streak_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/streak/domain/repository/streak_repository.dart';

/// Use case for checking if a streak is broken.
///
/// This use case handles the business logic for determining
/// whether the user's streak has been broken.
class IsStreakBrokenUseCase {
  /// The streak repository dependency.
  final StreakRepository repository;

  /// Creates an instance of [IsStreakBrokenUseCase].
  const IsStreakBrokenUseCase(this.repository);

  /// Executes the use case to check if streak is broken.
  ///
  /// Returns [Either<Failure, bool>] indicating if streak is broken or failure.
  Either<Failure, bool> execute(List<StreakEntity> entities, {DateTime? currentDate}) {
    return repository.isStreakBroken(entities, currentDate: currentDate);
  }
}
