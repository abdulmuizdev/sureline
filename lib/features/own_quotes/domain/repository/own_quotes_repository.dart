import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/own_quotes/domain/entity/own_quote_entity.dart';

abstract class OwnQuotesRepository {
  Future<Either<Failure, List<OwnQuoteEntity>>> getAllOwnQuotes();
  Future<Either<Failure, void>> addOwnQuote(OwnQuoteEntity ownQuote);
  Future<Either<Failure, void>> removeOwnQuote(int id);
}
