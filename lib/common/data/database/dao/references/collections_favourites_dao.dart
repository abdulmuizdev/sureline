import 'package:drift/drift.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/db/tables/collections_table.dart';
import 'package:sureline/core/db/tables/favourites.dart';
import 'package:sureline/core/db/tables/references/collections_favourites.dart';

part 'collections_favourites_dao.g.dart';

@DriftAccessor(tables: [CollectionsFavourites, CollectionsTable])
class CollectionsFavouritesDao extends DatabaseAccessor<AppDatabase>
    with _$CollectionsFavouritesDaoMixin {
  CollectionsFavouritesDao(AppDatabase db) : super(db);

  Future<List<CollectionsFavourite>> getAllCollectionsFavourites() {
    return select(collectionsFavourites).get();
  }

  Future<List<CollectionsTableData>> getCollectionsOfFavourite(
    int favouriteId,
  ) {
    return (select(collectionsTable)..where(
      (tbl) => tbl.id.isInQuery(
        selectOnly(collectionsFavourites)
          ..addColumns([collectionsFavourites.collectionId])
          ..where(collectionsFavourites.favouriteId.equals(favouriteId)),
      ),
    )).get();
  }

  Future<List<Favourite>> getFavouritesOfCollection(int collectionId) {
    return (select(favourites)..where(
      (tbl) => tbl.id.isInQuery(
        selectOnly(collectionsFavourites)
          ..addColumns([collectionsFavourites.favouriteId])
          ..where(collectionsFavourites.collectionId.equals(collectionId)),
      ),
    )).get();
  }

  Future<void> addCollectionFavourite(
    CollectionsFavouritesCompanion collectionFavourite,
  ) {
    return into(collectionsFavourites).insert(collectionFavourite);
  }

  Future<void> removeCollectionFavourite(int collectionId, int favouriteId) {
    return (delete(collectionsFavourites)..where(
      (tbl) =>
          tbl.collectionId.equals(collectionId) &
          tbl.favouriteId.equals(favouriteId),
    )).go();
  }
}
