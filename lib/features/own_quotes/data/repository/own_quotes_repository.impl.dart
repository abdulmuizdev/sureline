import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/own_quotes/data/data_source/own_quotes_data_source.dart';
import 'package:sureline/features/own_quotes/data/model/own_quote_model.dart';
import 'package:sureline/features/own_quotes/domain/entity/own_quote_entity.dart';
import 'package:sureline/features/own_quotes/domain/repository/own_quotes_repository.dart';

class OwnQuotesRepositoryImpl extends OwnQuotesRepository {
  final OwnQuotesDataSource ownQuotesDataSource;

  OwnQuotesRepositoryImpl(this.ownQuotesDataSource);

  @override
  Future<Either<Failure, List<OwnQuoteEntity>>> getAllOwnQuotes() async {
    return await ownQuotesDataSource.getAllOwnQuotes();
  }

  @override
  Future<Either<Failure, void>> addOwnQuote(OwnQuoteEntity ownQuote) async {
    return await ownQuotesDataSource.addOwnQuote(
      OwnQuoteModel.fromEntity(ownQuote),
    );
  }

  @override
  Future<Either<Failure, void>> removeOwnQuote(int id) async {
    return await ownQuotesDataSource.removeOwnQuote(id);
  }
}
