import 'package:drift/drift.dart';

class Quotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get quoteText => text()();
  TextColumn get author => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get shownAt => dateTime().nullable()();
}
