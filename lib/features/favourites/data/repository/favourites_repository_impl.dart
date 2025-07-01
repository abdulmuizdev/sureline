import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/favourites/data/data_source/favourites_data_source.dart';
import 'package:sureline/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/favourites/domain/repository/favourites_repository.dart';
import 'package:sureline/features/history/data/model/history_model.dart';
import 'package:sureline/features/history/domain/entity/history_entity.dart';
import 'package:sureline/features/own_quotes/data/model/own_quote_model.dart';
import 'package:sureline/features/own_quotes/domain/entity/own_quote_entity.dart';
import 'package:sureline/features/recommendation_algorithm/data/model/quote_model.dart';
import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';
import 'package:sureline/features/search/data/model/search_model.dart';
import 'package:sureline/features/search/domain/entity/search_entity.dart';

class FavouritesRepositoryImpl extends FavouritesRepository {
  final FavouritesDataSource dataSource;

  FavouritesRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<FavouriteEntity>>> getFavourites() async {
    return dataSource.getFavourites();
  }

  @override
  Future<Either<Failure, void>> addFavourite({
    QuoteEntity? quote,
    OwnQuoteEntity? ownQuote,
    HistoryEntity? history,
    SearchEntity? search,
  }) async {
    if (quote != null) {
      return dataSource.addFavourite(quote: QuoteModel.fromEntity(quote));
    } else if (ownQuote != null) {
      return dataSource.addFavourite(
        ownQuote: OwnQuoteModel.fromEntity(ownQuote!),
      );
    } else if (search != null) {
      return dataSource.addFavourite(search: SearchModel.fromEntity(search!));
    } else {
      return dataSource.addFavourite(
        history: HistoryModel.fromEntity(history!),
      );
    }
  }

  @override
  Future<Either<Failure, void>> removeFavourite({
    int? quoteId,
    int? ownQuoteId,
    int? historyId,
    int? searchId,
  }) async {
    return dataSource.removeFavourite(
      quoteId: quoteId,
      ownQuoteId: ownQuoteId,
      historyId: historyId,
      searchId: searchId,
    );
  }

  @override
  Future<Either<Failure, int>> getFavouritesCount() async {
    return dataSource.getFavouritesCount();
  }
}
