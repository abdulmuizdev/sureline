import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/data/data_sources/collections_data_source.dart';
import 'package:sureline/features/preferenecs/collections/data/model/collection_model.dart';
import 'package:sureline/features/preferenecs/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';
import 'package:sureline/features/preferenecs/favourites/data/model/favourite_model.dart';
import 'package:sureline/features/preferenecs/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/preferenecs/history/domain/entity/history_entity.dart';
import 'package:sureline/features/home/data/model/quote_model.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/entity/own_quote_entity.dart';
import 'package:sureline/features/preferenecs/search/domain/entity/search_entity.dart';

class CollectionsRepositoryImpl extends CollectionsRepository {
  final CollectionsDataSource dataSource;

  CollectionsRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<CollectionEntity>>> getCollections() async {
    return dataSource.getCollections();
  }

  @override
  Future<Either<Failure, void>> saveCollection(
    CollectionEntity collection,
  ) async {
    return dataSource.saveCollection(CollectionModel.fromEntity(collection));
  }

  @override
  Future<Either<Failure, void>> removeCollection(
    CollectionEntity collection,
  ) async {
    return dataSource.removeCollection(CollectionModel.fromEntity(collection));
  }

  @override
  Future<Either<Failure, void>> addFavouriteQuoteToCollection(
    int collectionId,
    int favouriteId,
  ) async {
    return dataSource.addFavouriteToCollection(collectionId, favouriteId);
  }

  @override
  Future<Either<Failure, void>> removeFavouriteQuoteFromCollection(
    int collectionId,
    int favouriteId,
  ) async {
    return dataSource.removeFavouriteFromCollection(collectionId, favouriteId);
  }

  @override
  Future<Either<Failure, List<FavouriteEntity>>> getFavouritesOfCollection(
    int collectionId,
  ) async {
    return dataSource.getFavouritesOfCollection(collectionId);
  }

  @override
  Future<Either<Failure, List<CollectionEntity>>> getCollectionsOfFavourite(
    int favouriteId,
  ) async {
    return dataSource.getCollectionsOfFavourite(favouriteId);
  }

  @override
  Future<Either<Failure, void>> addOwnQuoteToCollection(
    int collectionId,
    int ownQuoteId,
  ) async {
    return dataSource.addOwnQuoteToCollection(collectionId, ownQuoteId);
  }

  @override
  Future<Either<Failure, void>> removeOwnQuoteFromCollection(
    int collectionId,
    int ownQuoteId,
  ) async {
    return dataSource.removeOwnQuoteFromCollection(collectionId, ownQuoteId);
  }

  @override
  Future<Either<Failure, List<OwnQuoteEntity>>> getOwnQuotesOfCollection(
    int collectionId,
  ) async {
    return dataSource.getOwnQuotesOfCollection(collectionId);
  }

  @override
  Future<Either<Failure, List<CollectionEntity>>> getCollectionsOfOwnQuote(
    int ownQuoteId,
  ) async {
    return dataSource.getCollectionsOfOwnQuote(ownQuoteId);
  }

  @override
  Future<Either<Failure, void>> addHistoryToCollection(
    int collectionId,
    int quoteId,
  ) async {
    return dataSource.addHistoryToCollection(collectionId, quoteId);
  }

  @override
  Future<Either<Failure, void>> removeHistoryFromCollection(
    int collectionId,
    int quoteId,
  ) async {
    return dataSource.removeHistoryFromCollection(collectionId, quoteId);
  }

  @override
  Future<Either<Failure, List<CollectionEntity>>> getCollectionsOfHistory(
    int historyId,
  ) async {
    return dataSource.getCollectionsOfHistory(historyId);
  }

  @override
  Future<Either<Failure, List<HistoryEntity>>> getHistoryOfCollection(
    int collectionId,
  ) async {
    return dataSource.getHistoryOfCollection(collectionId);
  }

  @override
  Future<Either<Failure, void>> addSearchToCollection(
    int collectionId,
    int searchId,
  ) async {
    return dataSource.addSearchToCollection(collectionId, searchId);
  }

  @override
  Future<Either<Failure, void>> removeSearchFromCollection(
    int collectionId,
    int searchId,
  ) async {
    return dataSource.removeSearchFromCollection(collectionId, searchId);
  }

  @override
  Future<Either<Failure, List<CollectionEntity>>> getCollectionsOfSearch(
    int searchId,
  ) async {
    return dataSource.getCollectionsOfSearch(searchId);
  }

  @override
  Future<Either<Failure, List<SearchEntity>>> getSearchOfCollection(
    int collectionId,
  ) async {
    return dataSource.getSearchOfCollection(collectionId);
  }
}
