import 'package:drift/drift.dart';

class CollectionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get createdAt => text()();
}
