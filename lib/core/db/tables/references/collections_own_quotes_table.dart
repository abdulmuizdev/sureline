import 'package:drift/drift.dart';
import 'package:sureline/core/db/tables/collections_table.dart';
import 'package:sureline/core/db/tables/own_quotes_table.dart';

class CollectionsOwnQuotesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get collectionId =>
      integer().customConstraint('REFERENCES CollectionsTable(id) NOT NULL')();
  IntColumn get ownQuoteId =>
      integer().customConstraint('REFERENCES OwnQuotesTable(id) NOT NULL')();
}
