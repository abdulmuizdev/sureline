import 'package:drift/drift.dart';

class AuthorPrefsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get authorName => text()();
  BoolColumn get isPreferred => boolean().withDefault(const Constant(true))();
}
