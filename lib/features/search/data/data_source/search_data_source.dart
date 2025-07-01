import 'package:dartz/dartz.dart';
import 'package:sureline/common/data/database/dao/references/collections_search_dao.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/collections/data/model/collection_model.dart';
import 'package:sureline/features/recommendation_algorithm/data/database/dao/quotes_dao.dart';
import 'package:sureline/features/search/domain/entity/search_entity.dart';

abstract class SearchDataSource {
  Future<Either<Failure, List<SearchEntity>>> getSearch();
}

class SearchDataSourceImpl implements SearchDataSource {
  final QuotesDao quotesDao;
  final CollectionsSearchDao collectionsSearchDao;

  SearchDataSourceImpl(this.quotesDao, this.collectionsSearchDao);

  @override
  Future<Either<Failure, List<SearchEntity>>> getSearch() async {
    final quotes = await quotesDao.getAllQuotes();
    final List<SearchEntity> searchList = [];

    for (final quote in quotes) {
      final isFavourite = await quotesDao.isSearchFavourite(quote.id);
      final collections = await collectionsSearchDao.getCollectionsOfSearch(
        quote.id,
      );

      final collectionModels =
          collections.map((c) => CollectionModel.fromCollection(c)).toList();
      searchList.add(
        SearchEntity(
          id: quote.id,
          quoteText: quote.quoteText,
          isFavourite: isFavourite,
          collections: collectionModels,
        ),
      );
    }

    return Right(searchList);
  }
}
