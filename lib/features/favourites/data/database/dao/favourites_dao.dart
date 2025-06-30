import 'package:drift/drift.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/db/tables/favourites.dart';

part 'favourites_dao.g.dart';

@DriftAccessor(tables: [Favourites])
class FavouritesDao extends DatabaseAccessor<AppDatabase>
    with _$FavouritesDaoMixin {
  FavouritesDao(AppDatabase db) : super(db);

  Future<List<Favourite>> getAllFavourites() {
    return select(favourites).get();
  }

  Future<void> addFavourite(FavouritesCompanion favourite) {
    return into(favourites).insert(favourite);
  }

  Future<void> removeFavourite(int id) {
    return (delete(favourites)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> getFavouritesCount() {
    return (select(favourites)..orderBy([
      (t) => OrderingTerm.desc(t.id),
    ])).get().then((value) => value.length);
  }
}
