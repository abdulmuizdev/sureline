import 'package:drift/drift.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/db/tables/collections_table.dart';

part 'collections_dao.g.dart';

@DriftAccessor(tables: [CollectionsTable])
class CollectionsDao extends DatabaseAccessor<AppDatabase>
    with _$CollectionsDaoMixin {
  CollectionsDao(AppDatabase db) : super(db);

  Future<List<CollectionsTableData>> getAllCollections() {
    return select(collectionsTable).get();
  }

  Future<void> addCollection(CollectionsTableCompanion collection) {
    return into(collectionsTable).insert(collection);
  }

  Future<void> removeCollection(int id) {
    return (delete(collectionsTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
