import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';

import 'package:sureline/features/home/domain/repository/quote_repository.dart';

class IsShareGuideShownUseCase {
  final QuoteRepository quoteRepository;

  IsShareGuideShownUseCase(this.quoteRepository);

  Future<Either<Failure, bool>> execute() {
    return quoteRepository.isShareGuideShown();
  }
}
