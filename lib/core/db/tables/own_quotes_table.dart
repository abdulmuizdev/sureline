import 'package:drift/drift.dart';

class OwnQuotesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get quoteText => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
