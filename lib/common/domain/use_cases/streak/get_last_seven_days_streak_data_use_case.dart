import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/common/domain/entities/streak_display_entity.dart';
import 'package:sureline/features/streak/domain/repository/streak_repository.dart';

class GetLastSevenDaysStreakDataUseCase {
  final StreakRepository repository;

  GetLastSevenDaysStreakDataUseCase(this.repository);

  Either<Failure, List<StreakDisplayEntity>> execute(){
    return repository.getLastSevenDaysStreakData();
  }
}