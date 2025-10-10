import 'package:drift/drift.dart';

class Favourites extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get quote => text()();
  IntColumn get quoteId => integer().nullable().customConstraint('REFERENCES Quotes(id)')();
  IntColumn get ownQuoteId =>
      integer().nullable().customConstraint('REFERENCES OwnQuotesTable(id)')();
  IntColumn get historyId => integer().nullable().customConstraint('REFERENCES Quotes(id)')();
  IntColumn get searchId => integer().nullable().customConstraint('REFERENCES Quotes(id)')();
  TextColumn get createdAt => text()();
}
