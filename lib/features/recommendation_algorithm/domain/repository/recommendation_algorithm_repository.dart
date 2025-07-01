import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/author_preferences/data/model/author_pref_model.dart';
import 'package:sureline/features/general_settings/muted_content/domain/entity/muted_content_entity.dart';
import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';

abstract class RecommendationAlgorithmRepository {
  Future<Either<Failure, void>> initialize();
  Future<Either<Failure, List<QuoteEntity>>> getQuotes(int page);
  Future<Either<Failure, void>> markQuoteAsShown(int id);
  Future<Either<Failure, List<QuoteEntity>>> getShownQuotes();
  Future<Either<Failure, void>> updateAuthorPreference(
    AuthorPrefModel authorPrefModel,
  );
  Future<Either<Failure, List<AuthorPrefModel>>> getAuthorPreferences();
  Future<Either<Failure, void>> updateMutedContent({
    required bool withAuthor,
    required bool withoutAuthor,
  });
  Future<Either<Failure, List<MutedContentEntity>>> getMutedContent();
}
