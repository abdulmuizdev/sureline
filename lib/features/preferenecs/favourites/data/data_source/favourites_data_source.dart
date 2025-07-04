import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sureline/common/data/database/dao/references/collections_history_dao.dart';
import 'package:sureline/common/data/database/dao/references/collections_own_quotes_table_dao.dart';
import 'package:sureline/common/data/database/dao/references/collections_search_dao.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/common/data/database/dao/references/collections_favourites_dao.dart';
import 'package:sureline/features/preferenecs/collections/data/model/collection_model.dart';
import 'package:sureline/features/preferenecs/favourites/data/database/dao/favourites_dao.dart';
import 'package:sureline/features/preferenecs/favourites/data/model/favourite_model.dart';
import 'package:sureline/features/preferenecs/history/data/model/history_model.dart';
import 'package:sureline/features/preferenecs/own_quotes/data/model/own_quote_model.dart';
import 'package:sureline/features/recommendation_algorithm/data/model/quote_model.dart';
import 'package:sureline/features/preferenecs/search/data/model/search_model.dart';

abstract class FavouritesDataSource {
  Future<Either<Failure, List<FavouriteModel>>> getFavourites();
  Future<Either<Failure, void>> addFavourite({
    QuoteModel? quote,
    OwnQuoteModel? ownQuote,
    HistoryModel? history,
    SearchModel? search,
  });
  Future<Either<Failure, void>> removeFavourite({
    int? quoteId,
    int? ownQuoteId,
    int? historyId,
    int? searchId,
  });
  Future<Either<Failure, int>> getFavouritesCount();
}

class FavouritesDataSourceImpl extends FavouritesDataSource {
  final FavouritesDao favouritesDao;
  final CollectionsFavouritesDao collectionsFavouritesDao;
  final CollectionsOwnQuotesTableDao collectionsOwnQuotesTableDao;
  final CollectionsHistoryDao collectionsHistoryDao;
  final CollectionsSearchDao collectionsSearchDao;

  FavouritesDataSourceImpl({
    required this.favouritesDao,
    required this.collectionsFavouritesDao,
    required this.collectionsOwnQuotesTableDao,
    required this.collectionsHistoryDao,
    required this.collectionsSearchDao,
  });

  @override
  Future<Either<Failure, List<FavouriteModel>>> getFavourites() async {
    try {
      final favourites = await favouritesDao.getAllFavourites();
      final List<FavouriteModel> favouriteModels = [];

      for (final favourite in favourites) {
        List<CollectionModel> collectionModels = [];

        print('favourite.quoteId: ${favourite.quoteId}');
        print('favourite.ownQuoteId: ${favourite.ownQuoteId}');
        print('favourite.historyId: ${favourite.historyId}');
        print('favourite.searchId: ${favourite.searchId}');

        if (favourite.quoteId != null &&
            favourite.ownQuoteId == null &&
            favourite.historyId == null &&
            favourite.searchId == null) {
          final collections = await collectionsFavouritesDao
              .getCollectionsOfFavourite(favourite.id);

          collectionModels =
              collections
                  .map((c) => CollectionModel.fromCollection(c))
                  .toList();
        } else if (favourite.ownQuoteId != null &&
            favourite.quoteId == null &&
            favourite.historyId == null &&
            favourite.searchId == null) {
          collectionModels = await _getCollectionsOfOwnQuote(
            favourite.ownQuoteId!,
          );
        } else if (favourite.historyId != null &&
            // favourite.quoteId == null &&
            favourite.ownQuoteId == null &&
            favourite.searchId == null) {
          collectionModels = await _getCollectionsOfHistory(
            favourite.historyId!,
          );
        } else if (favourite.searchId != null &&
            favourite.quoteId == null &&
            favourite.ownQuoteId == null &&
            favourite.historyId == null) {
          collectionModels = await _getCollectionsOfSearch(favourite.searchId!);
        }

        favouriteModels.add(
          FavouriteModel(
            id: favourite.id,
            quote: favourite.quote,
            quoteId: favourite.quoteId,
            ownQuoteId: favourite.ownQuoteId,
            historyId: favourite.historyId,
            searchId: favourite.searchId,
            createdAt: favourite.createdAt,
            collections: collectionModels,
          ),
        );
      }

      return Right(favouriteModels);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  Future<List<CollectionModel>> _getCollectionsOfOwnQuote(
    int ownQuoteId,
  ) async {
    final collections = await collectionsOwnQuotesTableDao
        .getCollectionsOfOwnQuote(ownQuoteId);
    final collectionModels =
        collections.map((c) => CollectionModel.fromCollection(c)).toList();
    return collectionModels;
  }

  Future<List<CollectionModel>> _getCollectionsOfHistory(int historyId) async {
    final collections = await collectionsHistoryDao.getCollectionsOfHistory(
      historyId,
    );
    final collectionModels =
        collections.map((c) => CollectionModel.fromCollection(c)).toList();
    return collectionModels;
  }

  Future<List<CollectionModel>> _getCollectionsOfSearch(int searchId) async {
    final collections = await collectionsSearchDao.getCollectionsOfSearch(
      searchId,
    );
    final collectionModels =
        collections.map((c) => CollectionModel.fromCollection(c)).toList();
    return collectionModels;
  }

  @override
  Future<Either<Failure, void>> addFavourite({
    QuoteModel? quote,
    OwnQuoteModel? ownQuote,
    HistoryModel? history,
    SearchModel? search,
  }) async {
    try {
      FavouriteModel favouriteModel;
      if (quote != null) {
        print('check 1');
        favouriteModel = FavouriteModel.fromQuoteModel(quote);
      } else if (ownQuote != null) {
        print('check 2');
        favouriteModel = FavouriteModel.fromOwnQuoteModel(ownQuote);
      } else if (search != null) {
        print('check 3');
        favouriteModel = FavouriteModel.fromSearchModel(search);
      } else {
        print('check 4');
        favouriteModel = FavouriteModel.fromHistoryModel(history!);
      }
      await favouritesDao.addFavourite(favouriteModel.toFavouritesCompanion());
      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeFavourite({
    int? quoteId,
    int? ownQuoteId,
    int? historyId,
    int? searchId,
  }) async {
    try {
      final result = await favouritesDao.removeFavourite(
        quoteId: quoteId,
        ownQuoteId: ownQuoteId,
        historyId: historyId,
        searchId: searchId,
      );
      print('result is this $result');
      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, int>> getFavouritesCount() async {
    try {
      final count = await favouritesDao.getFavouritesCount();
      return Right(count);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }
}
