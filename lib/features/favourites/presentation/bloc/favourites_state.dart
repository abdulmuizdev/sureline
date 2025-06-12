import 'package:sureline/features/home/domain/entity/quote_entity.dart';

abstract class FavouritesState {
  const FavouritesState();
}

class Initial extends FavouritesState {}

class GotFavouriteQuotes extends FavouritesState {
  final List<QuoteEntity>? likedQuotes;
  const GotFavouriteQuotes(this.likedQuotes);
}