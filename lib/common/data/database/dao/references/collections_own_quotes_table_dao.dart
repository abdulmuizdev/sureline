import 'package:drift/drift.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/db/tables/collections_table.dart';
import 'package:sureline/core/db/tables/own_quotes_table.dart';
import 'package:sureline/core/db/tables/references/collections_own_quotes_table.dart';

part 'collections_own_quotes_table_dao.g.dart';

@DriftAccessor(
  tables: [CollectionsOwnQuotesTable, CollectionsTable, OwnQuotesTable],
)
class CollectionsOwnQuotesTableDao extends DatabaseAccessor<AppDatabase>
    with _$CollectionsOwnQuotesTableDaoMixin {
  CollectionsOwnQuotesTableDao(super.db);

  Future<List<CollectionsOwnQuotesTableData>> getAllCollectionsOwnQuotes() {
    return select(collectionsOwnQuotesTable).get();
  }

  Future<List<CollectionsTableData>> getCollectionsOfOwnQuote(int ownQuoteId) {
    return (select(collectionsTable)..where(
      (tbl) => tbl.id.isInQuery(
        selectOnly(collectionsOwnQuotesTable)
          ..addColumns([collectionsOwnQuotesTable.collectionId])
          ..where(collectionsOwnQuotesTable.ownQuoteId.equals(ownQuoteId)),
      ),
    )).get();
  }

  Future<List<OwnQuotesTableData>> getOwnQuotesOfCollection(int collectionId) {
    return (select(ownQuotesTable)..where(
      (tbl) => tbl.id.isInQuery(
        selectOnly(collectionsOwnQuotesTable)
          ..addColumns([collectionsOwnQuotesTable.ownQuoteId])
          ..where(collectionsOwnQuotesTable.collectionId.equals(collectionId)),
      ),
    )).get();
  }

  Future<void> addCollectionOwnQuote(
    CollectionsOwnQuotesTableCompanion collectionOwnQuote,
  ) {
    return into(collectionsOwnQuotesTable).insert(collectionOwnQuote);
  }

  Future<void> removeCollectionOwnQuote(int collectionId, int ownQuoteId) {
    return (delete(collectionsOwnQuotesTable)..where(
      (tbl) =>
          tbl.collectionId.equals(collectionId) &
          tbl.ownQuoteId.equals(ownQuoteId),
    )).go();
  }
}
