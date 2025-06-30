import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';

import 'package:sureline/features/home/domain/repository/quote_repository.dart';

class SetShareGuideToShownUseCase {
  final QuoteRepository quoteRepository;

  SetShareGuideToShownUseCase(this.quoteRepository);

  Future<Either<Failure, void>> execute() {
    return quoteRepository.setShareGuideShown();
  }
}
