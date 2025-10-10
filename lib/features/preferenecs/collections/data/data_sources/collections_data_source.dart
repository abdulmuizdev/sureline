/// Data source for collections operations.
///
/// Handles database operations for collections and quote relationships.
/// This data source manages the persistence layer for collections, including
/// CRUD operations and complex relationships between collections and different
/// types of quotes. It coordinates multiple DAOs to maintain data consistency
/// and provides a unified interface for collections data access.

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
import 'package:sureline/common/data/model/collections/collection_model.dart';
import 'package:sureline/common/data/model/collections/favourite_model.dart';
import 'package:sureline/common/data/model/collections/history_model.dart';
import 'package:sureline/common/data/model/collections/own_quote_model.dart';
import 'package:sureline/common/data/model/collections/search_model.dart';
import 'package:sureline/features/preferenecs/collections/data/database/dao/collections_dao.dart';
import 'package:sureline/features/preferenecs/favourites/data/database/dao/favourites_dao.dart';
import 'package:sureline/features/preferenecs/own_quotes/data/database/dao/own_quotes_dao.dart';
import 'package:sureline/core/app/app.dart';

/// Abstract data source for collections database operations.
///
/// Defines the interface for collections data operations, including CRUD
/// operations for collections and their relationships with different quote types.
/// This abstraction allows for different implementations (local database,
/// remote API, etc.) while maintaining a consistent interface.
abstract class CollectionsDataSource {
  /// Retrieves all collections with their associated quotes.
  Future<Either<Failure, List<CollectionModel>>> getCollections();

  /// Saves a new collection to the database.
  Future<Either<Failure, void>> saveCollection(CollectionModel collection);

  /// Removes a collection and its relationships.
  Future<Either<Failure, void>> removeCollection(CollectionModel collection);

  /// Adds a favourite quote to a collection.
  Future<Either<Failure, void>> addFavouriteToCollection(int collectionId, int favouriteId);

  /// Removes a favourite quote from a collection.
  Future<Either<Failure, void>> removeFavouriteFromCollection(int collectionId, int favouriteId);

  /// Gets all favourite quotes in a collection.
  Future<Either<Failure, List<FavouriteModel>>> getFavouritesOfCollection(int collectionId);

  /// Gets all collections containing a favourite quote.
  Future<Either<Failure, List<CollectionModel>>> getCollectionsOfFavourite(int favouriteId);

  /// Adds an own quote to a collection.
  Future<Either<Failure, void>> addOwnQuoteToCollection(int collectionId, int ownQuoteId);

  /// Removes an own quote from a collection.
  Future<Either<Failure, void>> removeOwnQuoteFromCollection(int collectionId, int ownQuoteId);

  /// Gets all own quotes in a collection.
  Future<Either<Failure, List<OwnQuoteModel>>> getOwnQuotesOfCollection(int collectionId);

  /// Gets all collections containing an own quote.
  Future<Either<Failure, List<CollectionModel>>> getCollectionsOfOwnQuote(int ownQuoteId);

  /// Adds a history quote to a collection.
  Future<Either<Failure, void>> addHistoryToCollection(int collectionId, int quoteId);

  /// Removes a history quote from a collection.
  Future<Either<Failure, void>> removeHistoryFromCollection(int collectionId, int quoteId);

  /// Gets all history quotes in a collection.
  Future<Either<Failure, List<HistoryModel>>> getHistoryOfCollection(int collectionId);

  /// Gets all collections containing a history quote.
  Future<Either<Failure, List<CollectionModel>>> getCollectionsOfHistory(int historyId);

  /// Adds a search quote to a collection.
  Future<Either<Failure, void>> addSearchToCollection(int collectionId, int searchId);

  /// Removes a search quote from a collection.
  Future<Either<Failure, void>> removeSearchFromCollection(int collectionId, int searchId);

  /// Gets all search quotes in a collection.
  Future<Either<Failure, List<SearchModel>>> getSearchOfCollection(
    int collectionId, {
    required bool isPremium,
  });

  /// Gets all collections containing a search quote.
  Future<Either<Failure, List<CollectionModel>>> getCollectionsOfSearch(int searchId);
}

/// Implementation of collections data source.
///
/// This class provides the concrete implementation of collections data operations
/// using the local SQLite database. It coordinates multiple DAOs to handle
/// complex relationships between collections and different quote types.
///
/// Key responsibilities:
/// - Managing collections CRUD operations
/// - Handling quote-collection relationships across all quote types
/// - Ensuring data consistency and proper error handling
/// - Coordinating multiple DAOs for complex operations
class CollectionsDataSourceImpl extends CollectionsDataSource {
  /// Shared preferences for app settings.
  final SharedPreferences prefs;

  /// DAO for collections-favourites relationships.
  final CollectionsFavouritesDao collectionsFavouritesDao;

  /// DAO for collections-own quotes relationships.
  final CollectionsOwnQuotesTableDao collectionsOwnQuotesDao;

  /// DAO for collections-history relationships.
  final CollectionsHistoryDao collectionsHistoryDao;

  /// DAO for collections-search relationships.
  final CollectionsSearchDao collectionsSearchDao;

  /// DAO for collections table operations.
  final CollectionsDao collectionsDao;

  /// DAO for own quotes operations.
  final OwnQuotesDao ownQuotesDao;

  /// DAO for favourites operations.
  final FavouritesDao favouritesDao;

  /// Creates a new data source implementation with required dependencies.
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
      final collectionModels = <CollectionModel>[];
      for (final collection in collections) {
        final favourites = await _getFavouritesData(collection.id);
        final ownQuotes = await _getOwnQuotesData(collection.id);
        final history = await _getHistoryData(collection.id);
        final search = await _getSearchData(collection.id, isPremium: App.isPremium);
        // print('favourites: ${favourites.length}');
        // print('ownQuotes: ${ownQuotes.length}');
        // print('history: ${history.length}');
        // print('search: ${search.length}');
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

  /// Retrieves and formats favourite quotes data for a collection.
  ///
  /// Fetches all favourite quotes associated with the collection and
  /// populates their collection relationships for bidirectional navigation.
  ///
  /// [collectionId]: The ID of the collection to query
  /// Returns: List of favourite models with populated collection data
  Future<List<FavouriteModel>> _getFavouritesData(int collectionId) async {
    final favourites = await collectionsFavouritesDao.getFavouritesOfCollection(collectionId);
    final favouriteModels = <FavouriteModel>[];

    for (final favourite in favourites) {
      final collections = await collectionsFavouritesDao.getCollectionsOfFavourite(favourite.id);
      final collectionModels = collections.map((c) => CollectionModel.fromCollection(c)).toList();

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

  /// Retrieves and formats own quotes data for a collection.
  ///
  /// Fetches all own quotes associated with the collection and
  /// populates their collection relationships and favourite status.
  ///
  /// [collectionId]: The ID of the collection to query
  /// Returns: List of own quote models with populated data
  Future<List<OwnQuoteModel>> _getOwnQuotesData(int collectionId) async {
    final ownQuotes = await collectionsOwnQuotesDao.getOwnQuotesOfCollection(collectionId);
    final ownQuoteModels = <OwnQuoteModel>[];

    for (final ownQuote in ownQuotes) {
      final collections = await collectionsOwnQuotesDao.getCollectionsOfOwnQuote(ownQuote.id);
      final collectionModels = collections.map((c) => CollectionModel.fromCollection(c)).toList();

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

  /// Retrieves and formats history quotes data for a collection.
  ///
  /// Fetches all history quotes associated with the collection and
  /// populates their collection relationships and favourite status.
  ///
  /// [collectionId]: The ID of the collection to query
  /// Returns: List of history models with populated data
  Future<List<HistoryModel>> _getHistoryData(int collectionId) async {
    final histories = await collectionsHistoryDao.getHistoryOfCollection(collectionId);
    // print('histories raw size from db: ${histories.length}');
    final historyModels = <HistoryModel>[];

    for (final history in histories) {
      final collections = await collectionsHistoryDao.getCollectionsOfHistory(history.id);
      final collectionModels = collections.map((c) => CollectionModel.fromCollection(c)).toList();

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

  /// Retrieves and formats search quotes data for a collection.
  ///
  /// Fetches all search quotes associated with the collection and
  /// populates their collection relationships and favourite status.
  ///
  /// [collectionId]: The ID of the collection to query
  /// [isPremium]: Whether the user has premium access
  /// Returns: List of search models with populated data
  Future<List<SearchModel>> _getSearchData(int collectionId, {required bool isPremium}) async {
    final searches = await collectionsSearchDao.getSearchOfCollection(
      collectionId,
      isPremium: isPremium,
    );

    final searchModels = <SearchModel>[];

    for (final search in searches) {
      final collections = await collectionsSearchDao.getCollectionsOfSearch(search.id);
      final collectionModels = collections.map((c) => CollectionModel.fromCollection(c)).toList();

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
  Future<Either<Failure, void>> saveCollection(CollectionModel collection) async {
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
  Future<Either<Failure, void>> removeCollection(CollectionModel collection) async {
    try {
      await collectionsDao.removeCollection(collection.id);

      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addFavouriteToCollection(int collectionId, int favouriteId) async {
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
      collectionsFavouritesDao.removeCollectionFavourite(collectionId, favouriteId);

      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<FavouriteModel>>> getFavouritesOfCollection(int collectionId) async {
    try {
      final favourites = await collectionsFavouritesDao.getFavouritesOfCollection(collectionId);
      final favouriteModels = <FavouriteModel>[];

      for (final favourite in favourites) {
        final collections = await collectionsFavouritesDao.getCollectionsOfFavourite(favourite.id);
        final collectionModels = collections.map((c) => CollectionModel.fromCollection(c)).toList();

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
  Future<Either<Failure, List<CollectionModel>>> getCollectionsOfFavourite(int favouriteId) async {
    try {
      final collections = await collectionsFavouritesDao.getCollectionsOfFavourite(favouriteId);
      final collectionModels = <CollectionModel>[];

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
  Future<Either<Failure, void>> addOwnQuoteToCollection(int collectionId, int ownQuoteId) async {
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
      await collectionsOwnQuotesDao.removeCollectionOwnQuote(collectionId, ownQuoteId);

      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<OwnQuoteModel>>> getOwnQuotesOfCollection(int collectionId) async {
    try {
      final ownQuotes = await collectionsOwnQuotesDao.getOwnQuotesOfCollection(collectionId);
      final ownQuoteModels = <OwnQuoteModel>[];

      for (final ownQuote in ownQuotes) {
        final collections = await collectionsOwnQuotesDao.getCollectionsOfOwnQuote(ownQuote.id);
        final collectionModels = collections.map((c) => CollectionModel.fromCollection(c)).toList();

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
  Future<Either<Failure, List<CollectionModel>>> getCollectionsOfOwnQuote(int ownQuoteId) async {
    try {
      final collections = await collectionsOwnQuotesDao.getCollectionsOfOwnQuote(ownQuoteId);
      final collectionModels = <CollectionModel>[];

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
  Future<Either<Failure, void>> addHistoryToCollection(int collectionId, int quoteId) async {
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
  Future<Either<Failure, void>> removeHistoryFromCollection(int collectionId, int quoteId) async {
    try {
      await collectionsHistoryDao.removeCollectionQuote(collectionId, quoteId);

      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<HistoryModel>>> getHistoryOfCollection(int collectionId) async {
    try {
      final histories = await collectionsHistoryDao.getHistoryOfCollection(collectionId);
      final historyModels = <HistoryModel>[];

      for (final history in histories) {
        final collections = await collectionsHistoryDao.getCollectionsOfHistory(history.id);
        final collectionModels = collections.map((c) => CollectionModel.fromCollection(c)).toList();

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
  Future<Either<Failure, List<CollectionModel>>> getCollectionsOfHistory(int historyId) async {
    try {
      final collections = await collectionsHistoryDao.getCollectionsOfHistory(historyId);
      final collectionModels = <CollectionModel>[];

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
  Future<Either<Failure, void>> addSearchToCollection(int collectionId, int searchId) async {
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
  Future<Either<Failure, void>> removeSearchFromCollection(int collectionId, int searchId) async {
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
    int collectionId, {
    required bool isPremium,
  }) async {
    try {
      final searches = await collectionsSearchDao.getSearchOfCollection(
        collectionId,
        isPremium: isPremium,
      );
      print('search raw size from db: ${searches.length}');
      final searchModels = <SearchModel>[];

      for (final search in searches) {
        final collections = await collectionsSearchDao.getCollectionsOfSearch(search.id);
        final collectionModels = collections.map((c) => CollectionModel.fromCollection(c)).toList();

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
  Future<Either<Failure, List<CollectionModel>>> getCollectionsOfSearch(int searchId) async {
    try {
      final collections = await collectionsSearchDao.getCollectionsOfSearch(searchId);
      final collectionModels = <CollectionModel>[];

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
