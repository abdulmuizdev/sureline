import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/streak/domain/repository/streak_repository.dart';

class GetTotalStreakScoreUseCase {
  final StreakRepository repository;
  GetTotalStreakScoreUseCase(this.repository);

  Either<Failure, int> execute(){
    return repository.getTotalStreakScore();
  }
}