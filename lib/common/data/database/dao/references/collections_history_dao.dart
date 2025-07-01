import 'package:drift/drift.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/db/tables/collections_table.dart';
import 'package:sureline/core/db/tables/own_quotes_table.dart';
import 'package:sureline/core/db/tables/quotes.dart';
import 'package:sureline/core/db/tables/collections_table.dart';
import 'package:sureline/core/db/tables/references/collections_own_quotes_table.dart';
import 'package:sureline/core/db/tables/references/collections_history.dart';

part 'collections_history_dao.g.dart';

@DriftAccessor(tables: [CollectionsHistoryQuotes, CollectionsTable, Quotes])
class CollectionsHistoryDao extends DatabaseAccessor<AppDatabase>
    with _$CollectionsHistoryDaoMixin {
  CollectionsHistoryDao(super.db);

  Future<List<CollectionsHistoryQuote>> getAllCollectionsHistoryQuotes() {
    return select(collectionsHistoryQuotes).get();
  }

  Future<List<CollectionsTableData>> getCollectionsOfHistory(int quoteId) {
    print('getting collections of history $quoteId');
    return (select(collectionsTable)..where(
      (tbl) => tbl.id.isInQuery(
        selectOnly(collectionsHistoryQuotes)
          ..addColumns([collectionsHistoryQuotes.collectionId])
          ..where(collectionsHistoryQuotes.quoteId.equals(quoteId)),
      ),
    )).get();
  }

  Future<List<Quote>> getHistoryOfCollection(int collectionId) {
    return (select(quotes)..where(
      (tbl) => tbl.id.isInQuery(
        selectOnly(collectionsHistoryQuotes)
          ..addColumns([collectionsHistoryQuotes.quoteId])
          ..where(collectionsHistoryQuotes.collectionId.equals(collectionId)),
      ),
    )).get();
  }

  Future<void> addCollectionQuote(
    CollectionsHistoryQuotesCompanion collectionHistoryQuote,
  ) {
    return into(collectionsHistoryQuotes).insert(collectionHistoryQuote);
  }

  Future<void> removeCollectionQuote(int collectionId, int quoteId) {
    return (delete(collectionsHistoryQuotes)..where(
      (tbl) =>
          tbl.collectionId.equals(collectionId) & tbl.quoteId.equals(quoteId),
    )).go();
  }
}
