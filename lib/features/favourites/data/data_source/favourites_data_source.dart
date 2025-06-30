import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/common/data/database/dao/references/collections_favourites_dao.dart';
import 'package:sureline/features/collections/data/model/collection_model.dart';
import 'package:sureline/features/favourites/data/database/dao/favourites_dao.dart';
import 'package:sureline/features/favourites/data/model/favourite_model.dart';
import 'package:sureline/features/recommendation_algorithm/data/model/quote_model.dart';

abstract class FavouritesDataSource {
  Future<Either<Failure, List<FavouriteModel>>> getFavourites();
  Future<Either<Failure, void>> addFavourite(QuoteModel quote);
  Future<Either<Failure, void>> removeFavourite(int id);
  Future<Either<Failure, int>> getFavouritesCount();
}

class FavouritesDataSourceImpl extends FavouritesDataSource {
  final FavouritesDao favouritesDao;
  final CollectionsFavouritesDao collectionsFavouritesDao;

  FavouritesDataSourceImpl({
    required this.favouritesDao,
    required this.collectionsFavouritesDao,
  });

  @override
  Future<Either<Failure, List<FavouriteModel>>> getFavourites() async {
    try {
      final favourites = await favouritesDao.getAllFavourites();
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
  Future<Either<Failure, void>> addFavourite(QuoteModel quote) async {
    try {
      final favouriteModel = FavouriteModel.fromQuoteModel(quote);
      await favouritesDao.addFavourite(favouriteModel.toFavouritesCompanion());
      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeFavourite(int id) async {
    try {
      await favouritesDao.removeFavourite(id);
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
