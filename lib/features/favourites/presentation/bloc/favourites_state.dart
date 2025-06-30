import 'package:sureline/features/favourites/domain/entity/favourite_entity.dart';

abstract class FavouritesState {
  const FavouritesState();
}

class Initial extends FavouritesState {}

class GotFavouriteQuotes extends FavouritesState {
  final List<FavouriteEntity>? quotes;
  const GotFavouriteQuotes(this.quotes);
}
