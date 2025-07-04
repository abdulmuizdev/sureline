import 'package:dartz/dartz.dart';
import 'package:sureline/common/data/database/dao/references/collections_history_dao.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/collections/data/model/collection_model.dart';
import 'package:sureline/features/preferenecs/history/data/model/history_model.dart';
import 'package:sureline/features/recommendation_algorithm/data/database/dao/quotes_dao.dart';

abstract class HistoryDataSource {
  Future<Either<Failure, List<HistoryModel>>> getHistory();
}

class HistoryDataSourceImpl implements HistoryDataSource {
  final QuotesDao quotesDao;
  final CollectionsHistoryDao collectionsQuotesTableDao;

  HistoryDataSourceImpl(this.quotesDao, this.collectionsQuotesTableDao);
  @override
  Future<Either<Failure, List<HistoryModel>>> getHistory() async {
    final quotes = await quotesDao.getShownQuotes();
    final List<HistoryModel> historyList = [];

    for (final quote in quotes) {
      final isFavourite = await quotesDao.isQuoteFavourite(quote.id);
      final collections = await collectionsQuotesTableDao
          .getCollectionsOfHistory(quote.id);
      print('collections: ${collections.length}');
      final collectionModels =
          collections.map((c) => CollectionModel.fromCollection(c)).toList();
      historyList.add(
        HistoryModel(
          id: quote.id,
          quoteText: quote.quoteText,
          isFavourite: isFavourite,
          collections: collectionModels,
        ),
      );
    }

    return Right(historyList);
  }
}
