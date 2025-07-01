import 'package:drift/drift.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/db/tables/collections_table.dart';
import 'package:sureline/core/db/tables/quotes.dart';
import 'package:sureline/core/db/tables/references/collections_search.dart';

part 'collections_search_dao.g.dart';

@DriftAccessor(tables: [CollectionsSearchQuotes, CollectionsTable, Quotes])
class CollectionsSearchDao extends DatabaseAccessor<AppDatabase>
    with _$CollectionsSearchDaoMixin {
  CollectionsSearchDao(super.db);

  Future<List<CollectionsSearchQuote>> getAllCollectionsSearchQuotes() {
    return select(collectionsSearchQuotes).get();
  }

  Future<List<CollectionsTableData>> getCollectionsOfSearch(int quoteId) {
    return (select(collectionsTable)..where(
      (tbl) => tbl.id.isInQuery(
        selectOnly(collectionsSearchQuotes)
          ..addColumns([collectionsSearchQuotes.collectionId])
          ..where(collectionsSearchQuotes.quoteId.equals(quoteId)),
      ),
    )).get();
  }

  Future<List<Quote>> getSearchOfCollection(int collectionId) {
    return (select(quotes)..where(
      (tbl) => tbl.id.isInQuery(
        selectOnly(collectionsSearchQuotes)
          ..addColumns([collectionsSearchQuotes.quoteId])
          ..where(collectionsSearchQuotes.collectionId.equals(collectionId)),
      ),
    )).get();
  }

  Future<void> addCollectionSearch(
    CollectionsSearchQuotesCompanion collectionSearchQuote,
  ) {
    return into(collectionsSearchQuotes).insert(collectionSearchQuote);
  }

  Future<void> removeCollectionSearch(int collectionId, int quoteId) {
    return (delete(collectionsSearchQuotes)..where(
      (tbl) =>
          tbl.collectionId.equals(collectionId) & tbl.quoteId.equals(quoteId),
    )).go();
  }
}
