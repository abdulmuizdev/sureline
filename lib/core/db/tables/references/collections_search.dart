import 'package:drift/drift.dart';
import 'package:sureline/core/db/tables/collections_table.dart';
import 'package:sureline/core/db/tables/quotes.dart';

class CollectionsSearchQuotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get collectionId =>
      integer().customConstraint('REFERENCES CollectionsTable(id) NOT NULL')();
  IntColumn get quoteId =>
      integer().customConstraint('REFERENCES Quotes(id) NOT NULL')();
}
