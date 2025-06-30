import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/own_quotes/domain/entity/own_quote_entity.dart';
import 'package:sureline/features/own_quotes/domain/repository/own_quotes_repository.dart';

class AddOwnQuoteUseCase {
  final OwnQuotesRepository ownQuotesRepository;

  AddOwnQuoteUseCase(this.ownQuotesRepository);

  Future<Either<Failure, void>> call(OwnQuoteEntity ownQuote) async {
    return await ownQuotesRepository.addOwnQuote(ownQuote);
  }
}
