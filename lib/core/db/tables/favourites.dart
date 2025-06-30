import 'package:drift/drift.dart';

class Favourites extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get quote => text()();
  TextColumn get createdAt => text()();
}
