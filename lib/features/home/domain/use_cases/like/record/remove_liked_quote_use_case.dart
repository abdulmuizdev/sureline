import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/entity/quote_entity.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

class RemoveLikedQuoteUseCase {
  final QuoteRepository repository;
  RemoveLikedQuoteUseCase(this.repository);

  Future<Either<Failure, void>> execute(QuoteEntity entity){
    return repository.removeLikedQuote(entity);
  }

}