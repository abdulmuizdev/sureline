import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/history/domain/entity/history_entity.dart';
import 'package:sureline/features/own_quotes/domain/entity/own_quote_entity.dart';
import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';
import 'package:sureline/features/search/domain/entity/search_entity.dart';

abstract class FavouritesRepository {
  Future<Either<Failure, List<FavouriteEntity>>> getFavourites();
  Future<Either<Failure, void>> addFavourite({
    QuoteEntity? quote,
    OwnQuoteEntity? ownQuote,
    HistoryEntity? history,
    SearchEntity? search,
  });
  Future<Either<Failure, void>> removeFavourite({
    int? quoteId,
    int? ownQuoteId,
    int? historyId,
    int? searchId,
  });
  Future<Either<Failure, int>> getFavouritesCount();
}
