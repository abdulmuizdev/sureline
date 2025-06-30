import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/own_quotes/domain/entity/own_quote_entity.dart';
import 'package:sureline/features/own_quotes/domain/repository/own_quotes_repository.dart';

class GetAllOwnQuotesUseCase {
  final OwnQuotesRepository ownQuotesRepository;

  GetAllOwnQuotesUseCase(this.ownQuotesRepository);

  Future<Either<Failure, List<OwnQuoteEntity>>> call() async {
    return await ownQuotesRepository.getAllOwnQuotes();
  }
}
