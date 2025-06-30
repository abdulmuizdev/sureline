import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/own_quotes/domain/repository/own_quotes_repository.dart';

class RemoveOwnQuoteUseCase {
  final OwnQuotesRepository ownQuotesRepository;

  RemoveOwnQuoteUseCase(this.ownQuotesRepository);

  Future<Either<Failure, void>> call(int id) async {
    return await ownQuotesRepository.removeOwnQuote(id);
  }
}
