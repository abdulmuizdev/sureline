import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';

import 'package:sureline/features/home/domain/repository/quote_repository.dart';

class SetOnboardingToCompletedUseCase {
  final QuoteRepository quoteRepository;

  SetOnboardingToCompletedUseCase(this.quoteRepository);

  Future<Either<Failure, void>> execute() {
    return quoteRepository.setOnboardingToCompleted();
  }
}
