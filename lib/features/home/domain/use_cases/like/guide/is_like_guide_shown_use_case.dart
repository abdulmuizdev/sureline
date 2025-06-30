import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';

import 'package:sureline/features/home/domain/repository/quote_repository.dart';

class IsLikeGuideShownUseCase {
  final QuoteRepository quoteRepository;

  IsLikeGuideShownUseCase(this.quoteRepository);

  Future<Either<Failure, bool>> execute() {
    return quoteRepository.isLikeGuideShown();
  }
}
