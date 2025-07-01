import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:sureline/common/data/database/dao/references/collections_own_quotes_table_dao.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/collections/data/model/collection_model.dart';
import 'package:sureline/features/own_quotes/data/database/dao/own_quotes_dao.dart';
import 'package:sureline/features/own_quotes/data/model/own_quote_model.dart';

abstract class OwnQuotesDataSource {
  Future<Either<Failure, List<OwnQuoteModel>>> getAllOwnQuotes();
  Future<Either<Failure, void>> addOwnQuote(OwnQuoteModel ownQuote);
  Future<Either<Failure, void>> removeOwnQuote(int id);
}

class OwnQuotesDataSourceImpl extends OwnQuotesDataSource {
  final OwnQuotesDao ownQuotesDao;
  final CollectionsOwnQuotesTableDao collectionsOwnQuotesDao;

  OwnQuotesDataSourceImpl(this.ownQuotesDao, this.collectionsOwnQuotesDao);

  @override
  Future<Either<Failure, List<OwnQuoteModel>>> getAllOwnQuotes() async {
    try {
      final ownQuotes = await ownQuotesDao.getAllOwnQuotes();
      final List<OwnQuoteModel> ownQuoteModels = [];

      for (final ownQuote in ownQuotes) {
        final collections = await collectionsOwnQuotesDao
            .getCollectionsOfOwnQuote(ownQuote.id);
        print('collections: ${collections.length}');
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
  Future<Either<Failure, void>> addOwnQuote(OwnQuoteModel ownQuote) async {
    try {
      final ownQuoteCompanion = OwnQuotesTableCompanion.insert(
        quoteText: ownQuote.quoteText,
        createdAt: Value(DateTime.parse(ownQuote.createdAt)),
      );
      await ownQuotesDao.addOwnQuote(ownQuoteCompanion);
      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeOwnQuote(int id) async {
    try {
      await ownQuotesDao.removeOwnQuote(id);
      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }
}
