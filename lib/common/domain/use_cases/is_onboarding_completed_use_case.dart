import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';

import 'package:sureline/features/home/domain/repository/quote_repository.dart';

class IsOnboardingCompletedUseCase {
  final QuoteRepository quoteRepository;

  IsOnboardingCompletedUseCase(this.quoteRepository);

  Future<Either<Failure, bool>> execute() {
    return quoteRepository.isOnboardingComplete();
  }
}
