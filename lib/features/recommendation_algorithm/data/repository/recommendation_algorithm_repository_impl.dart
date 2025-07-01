import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/author_preferences/data/model/author_pref_model.dart';
import 'package:sureline/features/general_settings/muted_content/domain/entity/muted_content_entity.dart';
import 'package:sureline/features/recommendation_algorithm/data/data_source/recommendation_algorithm_data_source.dart';
import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';
import 'package:sureline/features/recommendation_algorithm/domain/repository/recommendation_algorithm_repository.dart';

class RecommendationAlgorithmRepositoryImpl
    extends RecommendationAlgorithmRepository {
  final RecommendationAlgorithmDataSource dataSource;

  RecommendationAlgorithmRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, void>> initialize() async {
    return dataSource.initialize();
  }

  @override
  Future<Either<Failure, List<QuoteEntity>>> getQuotes(int page) async {
    return dataSource.getQuotes(page);
  }

  @override
  Future<Either<Failure, void>> markQuoteAsShown(int id) async {
    return dataSource.markQuoteAsShown(id);
  }

  @override
  Future<Either<Failure, List<QuoteEntity>>> getShownQuotes() async {
    return dataSource.getShownQuotes();
  }

  @override
  Future<Either<Failure, void>> updateAuthorPreference(
    AuthorPrefModel authorPrefModel,
  ) async {
    return dataSource.updateAuthorPreference(authorPrefModel);
  }

  @override
  Future<Either<Failure, List<AuthorPrefModel>>> getAuthorPreferences() async {
    return dataSource.getAuthorPreferences();
  }

  @override
  Future<Either<Failure, void>> updateMutedContent({
    required bool withAuthor,
    required bool withoutAuthor,
  }) {
    return dataSource.updateMutedContent(
      withAuthor: withAuthor,
      withoutAuthor: withoutAuthor,
    );
  }

  @override
  Future<Either<Failure, List<MutedContentEntity>>> getMutedContent() {
    return dataSource.getMutedContent();
  }
}
