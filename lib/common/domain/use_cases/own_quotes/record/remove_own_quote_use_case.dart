import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/entity/quote_entity.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

class RemoveOwnQuoteUseCase {
  final QuoteRepository repository;
  RemoveOwnQuoteUseCase(this.repository);

  Future<Either<Failure, void>> execute(QuoteEntity entity) {
    return repository.removeOwnQuote(entity);
  }
}
