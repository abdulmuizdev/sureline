import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/preferenecs/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/preferenecs/history/domain/entity/history_entity.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/entity/own_quote_entity.dart';
import 'package:sureline/features/preferenecs/search/domain/entity/search_entity.dart';

abstract class CollectionsRepository {
  Future<Either<Failure, List<CollectionEntity>>> getCollections();
  Future<Either<Failure, void>> saveCollection(CollectionEntity collection);
  Future<Either<Failure, void>> removeCollection(CollectionEntity collection);
  Future<Either<Failure, void>> addFavouriteQuoteToCollection(
    int collectionId,
    int favouriteId,
  );
  Future<Either<Failure, void>> removeFavouriteQuoteFromCollection(
    int collectionId,
    int favouriteId,
  );
  Future<Either<Failure, List<FavouriteEntity>>> getFavouritesOfCollection(
    int collectionId,
  );
  Future<Either<Failure, List<CollectionEntity>>> getCollectionsOfFavourite(
    int favouriteId,
  );
  Future<Either<Failure, void>> addOwnQuoteToCollection(
    int collectionId,
    int ownQuoteId,
  );
  Future<Either<Failure, void>> removeOwnQuoteFromCollection(
    int collectionId,
    int ownQuoteId,
  );
  Future<Either<Failure, List<OwnQuoteEntity>>> getOwnQuotesOfCollection(
    int collectionId,
  );
  Future<Either<Failure, List<CollectionEntity>>> getCollectionsOfOwnQuote(
    int ownQuoteId,
  );
  Future<Either<Failure, void>> addHistoryToCollection(
    int collectionId,
    int quoteId,
  );
  Future<Either<Failure, void>> removeHistoryFromCollection(
    int collectionId,
    int quoteId,
  );
  Future<Either<Failure, List<CollectionEntity>>> getCollectionsOfHistory(
    int historyId,
  );
  Future<Either<Failure, List<HistoryEntity>>> getHistoryOfCollection(
    int collectionId,
  );

  Future<Either<Failure, void>> addSearchToCollection(
    int collectionId,
    int searchId,
  );
  Future<Either<Failure, void>> removeSearchFromCollection(
    int collectionId,
    int searchId,
  );
  Future<Either<Failure, List<CollectionEntity>>> getCollectionsOfSearch(
    int searchId,
  );
  Future<Either<Failure, List<SearchEntity>>> getSearchOfCollection(
    int collectionId,
  );
}
