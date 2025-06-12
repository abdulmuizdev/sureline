import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/streak_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/streak/domain/repository/streak_repository.dart';

class IsStreakBrokenUseCase {
  final StreakRepository repository;

  IsStreakBrokenUseCase(this.repository);

  Either<Failure, bool> execute(
    List<StreakEntity> entities, {
    DateTime? currentDate,
  }) {
    return repository.isStreakBroken(entities, currentDate: currentDate);
  }
}
