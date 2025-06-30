import 'package:drift/drift.dart';
import 'package:sureline/core/db/tables/collections_table.dart';
import 'package:sureline/core/db/tables/favourites.dart';

class CollectionsFavourites extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get collectionId =>
      integer().customConstraint('REFERENCES CollectionsTable(id) NOT NULL')();
  IntColumn get favouriteId =>
      integer().customConstraint('REFERENCES Favourites(id) NOT NULL')();
}
