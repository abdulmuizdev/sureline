import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/data/model/author_pref_model.dart';
import 'package:sureline/features/preferenecs/general_settings/muted_content/domain/entity/muted_content_entity.dart';
import 'package:sureline/common/domain/entities/recommendation_algorithm/quote_entity.dart';

abstract class RecommendationAlgorithmRepository {
  Future<Either<Failure, void>> initialize({required bool isPremium});
  Future<Either<Failure, List<QuoteEntity>>> getQuotes({
    int? page,
    int? limit,
    required bool isPremium,
  });
  Future<Either<Failure, void>> markQuoteAsShown(int id);
  Future<Either<Failure, List<QuoteEntity>>> getShownQuotes({required bool isPremium});
  Future<Either<Failure, void>> updateAuthorPreference(
    AuthorPrefModel authorPrefModel, {
    required bool isPremium,
  });
  Future<Either<Failure, List<AuthorPrefModel>>> getAuthorPreferences();
  Future<Either<Failure, void>> updateMutedContent({
    required bool withAuthor,
    required bool withoutAuthor,
    required bool isPremium,
  });
  Future<Either<Failure, List<MutedContentEntity>>> getMutedContent();
}
