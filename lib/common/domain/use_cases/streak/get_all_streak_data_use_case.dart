import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/streak_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/streak/domain/repository/streak_repository.dart';

class GetAllStreakDataUseCase {
  final StreakRepository repository;

  GetAllStreakDataUseCase(this.repository);

  Either<Failure, List<StreakEntity>> execute() {
    return repository.getAllStreakData();
  }
}
