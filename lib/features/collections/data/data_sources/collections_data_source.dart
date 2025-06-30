import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/common/data/database/dao/references/collections_own_quotes_table_dao.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/common/data/database/dao/references/collections_favourites_dao.dart';
import 'package:sureline/features/collections/data/database/dao/collections_dao.dart';
import 'package:sureline/features/collections/data/model/collection_model.dart';
import 'package:sureline/features/favourites/data/model/favourite_model.dart';
import 'package:sureline/features/own_quotes/data/model/own_quote_model.dart';

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
}

class CollectionsDataSourceImpl extends CollectionsDataSource {
  final SharedPreferences prefs;
  final CollectionsFavouritesDao collectionsFavouritesDao;
  final CollectionsOwnQuotesTableDao collectionsOwnQuotesDao;
  final CollectionsDao collectionsDao;

  CollectionsDataSourceImpl(
    this.prefs,
    this.collectionsFavouritesDao,
    this.collectionsOwnQuotesDao,
    this.collectionsDao,
  );

  @override
  Future<Either<Failure, List<CollectionModel>>> getCollections() async {
    try {
      final collections = await collectionsDao.getAllCollections();
      final List<CollectionModel> collectionModels = [];
      for (final collection in collections) {
        final favourites = await _getFavouritesData(collection.id);
        final ownQuotes = await _getOwnQuotesData(collection.id);
        collectionModels.add(
          CollectionModel(
            id: collection.id,
            name: collection.name,
            favouriteQuotes: favourites,
            ownQuotes: ownQuotes,
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

      ownQuoteModels.add(
        OwnQuoteModel(
          id: ownQuote.id,
          quoteText: ownQuote.quoteText,
          createdAt: ownQuote.createdAt.toIso8601String(),
          collections: collectionModels,
        ),
      );
    }
    return ownQuoteModels;
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

        ownQuoteModels.add(
          OwnQuoteModel(
            id: ownQuote.id,
            quoteText: ownQuote.quoteText,
            createdAt: ownQuote.createdAt.toIso8601String(),
            collections: collectionModels,
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
}
