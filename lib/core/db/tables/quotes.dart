import 'package:drift/drift.dart';

class Quotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get quoteText => text()();
  TextColumn get author => text().nullable()();
  BoolColumn get isRestricted => boolean().withDefault(const Constant(false))();
  IntColumn get order => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get shownAt => dateTime().nullable()();
}
