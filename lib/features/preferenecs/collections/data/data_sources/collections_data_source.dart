import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/common/data/database/dao/references/collections_own_quotes_table_dao.dart';
import 'package:sureline/common/data/database/dao/references/collections_history_dao.dart';
import 'package:sureline/common/data/database/dao/references/collections_search_dao.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/common/data/database/dao/references/collections_favourites_dao.dart';
import 'package:sureline/features/preferenecs/collections/data/database/dao/collections_dao.dart';
import 'package:sureline/features/preferenecs/collections/data/model/collection_model.dart';
import 'package:sureline/features/preferenecs/favourites/data/database/dao/favourites_dao.dart';
import 'package:sureline/features/preferenecs/favourites/data/model/favourite_model.dart';
import 'package:sureline/features/preferenecs/history/data/model/history_model.dart';
import 'package:sureline/features/preferenecs/own_quotes/data/database/dao/own_quotes_dao.dart';
import 'package:sureline/features/preferenecs/own_quotes/data/model/own_quote_model.dart';
import 'package:sureline/features/preferenecs/search/data/model/search_model.dart';

abstract class CollectionsDataSource {
  Future<Either<Failure, List<CollectionModel>>> getCollections();
  Future<Either<Failure, void>> saveCollection(CollectionModel collection);
  Future<Either<Failure, void>> removeCollection(CollectionModel collection);

  Future<Either<Failure, void>> addFavouriteToCollection(
    int collectionId,
    int favouriteId,
  );
  Future<Either<Failure, void>> removeFavouriteFromCollection(
    int collectionId,
    int favouriteId,
  );
  Future<Either<Failure, List<FavouriteModel>>> getFavouritesOfCollection(
    int collectionId,
  );
  Future<Either<Failure, List<CollectionModel>>> getCollectionsOfFavourite(
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
  Future<Either<Failure, List<OwnQuoteModel>>> getOwnQuotesOfCollection(
    int collectionId,
  );
  Future<Either<Failure, List<CollectionModel>>> getCollectionsOfOwnQuote(
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

  Future<Either<Failure, List<HistoryModel>>> getHistoryOfCollection(
    int collectionId,
  );
  Future<Either<Failure, List<CollectionModel>>> getCollectionsOfHistory(
    int historyId,
  );

  Future<Either<Failure, void>> addSearchToCollection(
    int collectionId,
    int searchId,
  );
  Future<Either<Failure, void>> removeSearchFromCollection(
    int collectionId,
    int searchId,
  );

  Future<Either<Failure, List<SearchModel>>> getSearchOfCollection(
    int collectionId,
  );
  Future<Either<Failure, List<CollectionModel>>> getCollectionsOfSearch(
    int searchId,
  );
}

class CollectionsDataSourceImpl extends CollectionsDataSource {
  final SharedPreferences prefs;
  final CollectionsFavouritesDao collectionsFavouritesDao;
  final CollectionsOwnQuotesTableDao collectionsOwnQuotesDao;
  final CollectionsHistoryDao collectionsHistoryDao;
  final CollectionsSearchDao collectionsSearchDao;
  final CollectionsDao collectionsDao;
  final OwnQuotesDao ownQuotesDao;
  final FavouritesDao favouritesDao;
  CollectionsDataSourceImpl(
    this.prefs,
    this.collectionsFavouritesDao,
    this.collectionsOwnQuotesDao,
    this.collectionsHistoryDao,
    this.collectionsSearchDao,
    this.collectionsDao,
    this.ownQuotesDao,
    this.favouritesDao,
  );

  @override
  Future<Either<Failure, List<CollectionModel>>> getCollections() async {
    try {
      final collections = await collectionsDao.getAllCollections();
      final List<CollectionModel> collectionModels = [];
      for (final collection in collections) {
        final favourites = await _getFavouritesData(collection.id);
        final ownQuotes = await _getOwnQuotesData(collection.id);
        final history = await _getHistoryData(collection.id);
        final search = await _getSearchData(collection.id);
        collectionModels.add(
          CollectionModel(
            id: collection.id,
            name: collection.name,
            favouriteQuotes: favourites,
            ownQuotes: ownQuotes,
            historyQuotes: history,
            searchQuotes: search,
          ),
        );
      }
      return Right(collectionModels);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  Future<List<FavouriteModel>> _getFavouritesData(int collectionId) async {
    final favourites = await collectionsFavouritesDao.getFavouritesOfCollection(
      collectionId,
    );
    final List<FavouriteModel> favouriteModels = [];

    for (final favourite in favourites) {
      final collections = await collectionsFavouritesDao
          .getCollectionsOfFavourite(favourite.id);
      final collectionModels =
          collections.map((c) => CollectionModel.fromCollection(c)).toList();

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
    return favouriteModels;
  }

  Future<List<OwnQuoteModel>> _getOwnQuotesData(int collectionId) async {
    final ownQuotes = await collectionsOwnQuotesDao.getOwnQuotesOfCollection(
      collectionId,
    );
    final List<OwnQuoteModel> ownQuoteModels = [];

    for (final ownQuote in ownQuotes) {
      final collections = await collectionsOwnQuotesDao
          .getCollectionsOfOwnQuote(ownQuote.id);
      final collectionModels =
          collections.map((c) => CollectionModel.fromCollection(c)).toList();

      final isFavourite = await ownQuotesDao.isOwnQuoteFavourite(ownQuote.id);

      ownQuoteModels.add(
        OwnQuoteModel(
          id: ownQuote.id,
          quoteText: ownQuote.quoteText,
          createdAt: ownQuote.createdAt.toIso8601String(),
          collections: collectionModels,
          isFavourite: isFavourite,
        ),
      );
    }
    return ownQuoteModels;
  }

  Future<List<HistoryModel>> _getHistoryData(int collectionId) async {
    final histories = await collectionsHistoryDao.getHistoryOfCollection(
      collectionId,
    );
    print('histories raw size from db: ${histories.length}');
    final List<HistoryModel> historyModels = [];

    for (final history in histories) {
      final collections = await collectionsHistoryDao.getCollectionsOfHistory(
        history.id,
      );
      final collectionModels =
          collections.map((c) => CollectionModel.fromCollection(c)).toList();

      final isFavourite = await favouritesDao.isFavourite(history.id);

      historyModels.add(
        HistoryModel(
          id: history.id,
          quoteText: history.quoteText,
          collections: collectionModels,
          isFavourite: isFavourite,
        ),
      );
    }
    return historyModels;
  }

  Future<List<SearchModel>> _getSearchData(int collectionId) async {
    final searches = await collectionsSearchDao.getSearchOfCollection(
      collectionId,
    );
    print('searches raw size from db: ${searches.length}');
    final List<SearchModel> searchModels = [];

    for (final search in searches) {
      final collections = await collectionsSearchDao.getCollectionsOfSearch(
        search.id,
      );
      final collectionModels =
          collections.map((c) => CollectionModel.fromCollection(c)).toList();

      final isFavourite = await favouritesDao.isFavourite(search.id);

      searchModels.add(
        SearchModel(
          id: search.id,
          quoteText: search.quoteText,
          collections: collectionModels,
          isFavourite: isFavourite,
        ),
      );
    }
    return searchModels;
  }

  @override
  Future<Either<Failure, void>> saveCollection(
    CollectionModel collection,
  ) async {
    try {
      await collectionsDao.addCollection(
        CollectionsTableCompanion(
          name: Value(collection.name),
          createdAt: Value(DateTime.now().toIso8601String()),
        ),
      );

      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeCollection(
    CollectionModel collection,
  ) async {
    try {
      await collectionsDao.removeCollection(collection.id);

      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addFavouriteToCollection(
    int collectionId,
    int favouriteId,
  ) async {
    try {
      collectionsFavouritesDao.addCollectionFavourite(
        CollectionsFavouritesCompanion(
          collectionId: Value(collectionId),
          favouriteId: Value(favouriteId),
        ),
      );

      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeFavouriteFromCollection(
    int collectionId,
    int favouriteId,
  ) async {
    try {
      collectionsFavouritesDao.removeCollectionFavourite(
        collectionId,
        favouriteId,
      );

      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<FavouriteModel>>> getFavouritesOfCollection(
    int collectionId,
  ) async {
    try {
      final favourites = await collectionsFavouritesDao
          .getFavouritesOfCollection(collectionId);
      final List<FavouriteModel> favouriteModels = [];

      for (final favourite in favourites) {
        final collections = await collectionsFavouritesDao
            .getCollectionsOfFavourite(favourite.id);
        final collectionModels =
            collections.map((c) => CollectionModel.fromCollection(c)).toList();

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

  @override
  Future<Either<Failure, List<CollectionModel>>> getCollectionsOfFavourite(
    int favouriteId,
  ) async {
    try {
      final collections = await collectionsFavouritesDao
          .getCollectionsOfFavourite(favouriteId);
      final List<CollectionModel> collectionModels = [];

      for (final collection in collections) {
        collectionModels.add(CollectionModel.fromCollection(collection));
      }

      return Right(collectionModels);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addOwnQuoteToCollection(
    int collectionId,
    int ownQuoteId,
  ) async {
    try {
      print('adding own quote to collection: $collectionId, $ownQuoteId');
      await collectionsOwnQuotesDao.addCollectionOwnQuote(
        CollectionsOwnQuotesTableCompanion(
          collectionId: Value(collectionId),
          ownQuoteId: Value(ownQuoteId),
        ),
      );

      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeOwnQuoteFromCollection(
    int collectionId,
    int ownQuoteId,
  ) async {
    try {
      await collectionsOwnQuotesDao.removeCollectionOwnQuote(
        collectionId,
        ownQuoteId,
      );

      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<OwnQuoteModel>>> getOwnQuotesOfCollection(
    int collectionId,
  ) async {
    try {
      final ownQuotes = await collectionsOwnQuotesDao.getOwnQuotesOfCollection(
        collectionId,
      );
      final List<OwnQuoteModel> ownQuoteModels = [];

      for (final ownQuote in ownQuotes) {
        final collections = await collectionsOwnQuotesDao
            .getCollectionsOfOwnQuote(ownQuote.id);
        final collectionModels =
            collections.map((c) => CollectionModel.fromCollection(c)).toList();

        final isFavourite = await ownQuotesDao.isOwnQuoteFavourite(ownQuote.id);

        ownQuoteModels.add(
          OwnQuoteModel(
            id: ownQuote.id,
            quoteText: ownQuote.quoteText,
            createdAt: ownQuote.createdAt.toIso8601String(),
            collections: collectionModels,
            isFavourite: isFavourite,
          ),
        );
      }

      return Right(ownQuoteModels);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<CollectionModel>>> getCollectionsOfOwnQuote(
    int ownQuoteId,
  ) async {
    try {
      final collections = await collectionsOwnQuotesDao
          .getCollectionsOfOwnQuote(ownQuoteId);
      final List<CollectionModel> collectionModels = [];

      for (final collection in collections) {
        collectionModels.add(CollectionModel.fromCollection(collection));
      }

      return Right(collectionModels);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addHistoryToCollection(
    int collectionId,
    int quoteId,
  ) async {
    try {
      print('adding history to collection: $collectionId, $quoteId');
      await collectionsHistoryDao.addCollectionQuote(
        CollectionsHistoryQuotesCompanion(
          collectionId: Value(collectionId),
          quoteId: Value(quoteId),
        ),
      );

      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeHistoryFromCollection(
    int collectionId,
    int quoteId,
  ) async {
    try {
      await collectionsHistoryDao.removeCollectionQuote(collectionId, quoteId);

      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<HistoryModel>>> getHistoryOfCollection(
    int collectionId,
  ) async {
    try {
      final histories = await collectionsHistoryDao.getHistoryOfCollection(
        collectionId,
      );
      print('history raw size from db: ${histories.length}');
      final List<HistoryModel> historyModels = [];

      for (final history in histories) {
        final collections = await collectionsHistoryDao.getCollectionsOfHistory(
          history.id,
        );
        final collectionModels =
            collections.map((c) => CollectionModel.fromCollection(c)).toList();

        final isFavourite = await favouritesDao.isFavourite(history.id);

        historyModels.add(
          HistoryModel(
            id: history.id,
            quoteText: history.quoteText,

            collections: collectionModels,
            isFavourite: isFavourite,
          ),
        );
      }

      return Right(historyModels);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<CollectionModel>>> getCollectionsOfHistory(
    int historyId,
  ) async {
    try {
      final collections = await collectionsHistoryDao.getCollectionsOfHistory(
        historyId,
      );
      final List<CollectionModel> collectionModels = [];

      for (final collection in collections) {
        collectionModels.add(CollectionModel.fromCollection(collection));
      }

      return Right(collectionModels);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addSearchToCollection(
    int collectionId,
    int searchId,
  ) async {
    try {
      print('adding search to collection: $collectionId, $searchId');
      await collectionsSearchDao.addCollectionSearch(
        CollectionsSearchQuotesCompanion(
          collectionId: Value(collectionId),
          quoteId: Value(searchId),
        ),
      );

      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeSearchFromCollection(
    int collectionId,
    int searchId,
  ) async {
    try {
      await collectionsSearchDao.removeCollectionSearch(collectionId, searchId);

      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<SearchModel>>> getSearchOfCollection(
    int collectionId,
  ) async {
    try {
      final searches = await collectionsSearchDao.getSearchOfCollection(
        collectionId,
      );
      print('search raw size from db: ${searches.length}');
      final List<SearchModel> searchModels = [];

      for (final search in searches) {
        final collections = await collectionsSearchDao.getCollectionsOfSearch(
          search.id,
        );
        final collectionModels =
            collections.map((c) => CollectionModel.fromCollection(c)).toList();

        final isFavourite = await favouritesDao.isFavourite(search.id);

        searchModels.add(
          SearchModel(
            id: search.id,
            quoteText: search.quoteText,

            collections: collectionModels,
            isFavourite: isFavourite,
          ),
        );
      }

      return Right(searchModels);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<CollectionModel>>> getCollectionsOfSearch(
    int searchId,
  ) async {
    try {
      final collections = await collectionsSearchDao.getCollectionsOfSearch(
        searchId,
      );
      final List<CollectionModel> collectionModels = [];

      for (final collection in collections) {
        collectionModels.add(CollectionModel.fromCollection(collection));
      }

      return Right(collectionModels);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }
}
