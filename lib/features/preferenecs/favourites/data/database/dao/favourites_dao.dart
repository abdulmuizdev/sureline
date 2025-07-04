import 'package:drift/drift.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/db/tables/favourites.dart';
import 'package:sureline/features/home/data/data_source/quote_data_source.dart';

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

  Future<bool> isFavourite(int quoteId) {
    return (select(favourites)..where(
      (tbl) => tbl.quoteId.equals(quoteId),
    )).get().then((value) => value.isNotEmpty);
  }

  Future<int> removeFavourite({
    int? quoteId,
    int? ownQuoteId,
    int? historyId,
    int? searchId,
  }) {
    final query = delete(favourites);

    if (quoteId != null) {
      print('check 1');
      query.where((tbl) => tbl.quoteId.equals(quoteId));
    } else if (ownQuoteId != null) {
      print('check 2');
      query.where((tbl) => tbl.ownQuoteId.equals(ownQuoteId));
    } else if (searchId != null) {
      print('check 3');
      query.where((tbl) => tbl.searchId.equals(searchId));
    } else {
      print('check 4');
      query.where((tbl) => tbl.historyId.equals(historyId!));
    }

    return query.go();
  }

  Future<int> getFavouritesCount() {
    return (select(favourites)..orderBy([
      (t) => OrderingTerm.desc(t.id),
    ])).get().then((value) => value.length);
  }
}
