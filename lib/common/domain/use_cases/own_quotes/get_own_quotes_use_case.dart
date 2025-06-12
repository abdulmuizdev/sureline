import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/entity/quote_entity.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

class GetOwnQuotesUseCase {
  final QuoteRepository repository;
  GetOwnQuotesUseCase(this.repository);

  Either<Failure, List<QuoteEntity>?> execute() {
    return repository.getOwnQuote();
  }
}
