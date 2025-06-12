import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/entity/quote_entity.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

class IncrementLikeCountUseCase {
  final QuoteRepository quoteRepository;

  IncrementLikeCountUseCase(this.quoteRepository);

  Future<Either<Failure, int>> execute() {
    return quoteRepository.incrementLikeCount();
  }
}