import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/entity/quote_entity.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

class GetQuotesUseCase {
  final QuoteRepository quoteRepository;

  GetQuotesUseCase(this.quoteRepository);

  Future<Either<Failure, List<QuoteEntity>>> execute() {
    return quoteRepository.getQuotes();
  }
}