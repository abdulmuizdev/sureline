import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';

abstract class RecommendationAlgorithmRepository {
  Future<Either<Failure, void>> initialize();
  Future<Either<Failure, List<QuoteEntity>>> getQuotes(int page);
  Future<Either<Failure, void>> markQuoteAsShown(int id);
  Future<Either<Failure, List<QuoteEntity>>> getShownQuotes();
}
