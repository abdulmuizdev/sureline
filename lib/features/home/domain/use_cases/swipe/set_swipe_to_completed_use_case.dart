import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';

import 'package:sureline/features/home/domain/repository/quote_repository.dart';

class SetSwipeToCompletedUseCase {
  final QuoteRepository quoteRepository;

  SetSwipeToCompletedUseCase(this.quoteRepository);

  Future<Either<Failure, void>> execute() {
    return quoteRepository.setSwipeToCompleted();
  }
}
