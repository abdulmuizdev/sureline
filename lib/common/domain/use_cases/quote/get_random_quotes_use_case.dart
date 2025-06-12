import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/entity/quote_entity.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

class GetRandomQuotesUseCase {
  final QuoteRepository repository;
  GetRandomQuotesUseCase(this.repository);

  Future<Either<Failure, List<QuoteEntity>>> execute(int qty){
    return repository.getRandomQuotes(qty);
  }
}