import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/streak/domain/repository/streak_repository.dart';

class LogStreakEntryUseCase {
  final StreakRepository repository;
  LogStreakEntryUseCase(this.repository);

  Future<Either<Failure, void>> execute(){
    return repository.logStreakEntry();
  }
}