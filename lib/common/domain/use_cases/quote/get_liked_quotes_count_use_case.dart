import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

class GetLikedQuotesCountUseCase {
  final QuoteRepository repository;
  GetLikedQuotesCountUseCase(this.repository);

  Either<Failure, int> execute(){
    return repository.getLikedQuotesCount();
  }
}