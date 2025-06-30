import 'package:drift/drift.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/db/tables/own_quotes_table.dart';

part 'own_quotes_dao.g.dart';

@DriftAccessor(tables: [OwnQuotesTable])
class OwnQuotesDao extends DatabaseAccessor<AppDatabase>
    with _$OwnQuotesDaoMixin {
  OwnQuotesDao(AppDatabase db) : super(db);

  Future<List<OwnQuotesTableData>> getAllOwnQuotes() {
    return select(ownQuotesTable).get();
  }

  Future<void> addOwnQuote(OwnQuotesTableCompanion ownQuote) {
    return into(ownQuotesTable).insert(ownQuote);
  }

  Future<void> removeOwnQuote(int id) {
    return (delete(ownQuotesTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
