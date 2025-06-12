import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/entity/quote_entity.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

class GetQuotesSearchResultsUseCase {
  final QuoteRepository repository;
  GetQuotesSearchResultsUseCase(this.repository);

  Future<Either<Failure, List<QuoteEntity>>> execute(String query, int page){
    return repository.getQuotesSearchResults(query, page);
  }
}