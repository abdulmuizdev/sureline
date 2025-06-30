import 'package:sureline/features/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/favourites/domain/entity/favourite_entity.dart';

abstract class FavouritesEvent {
  const FavouritesEvent();
}

class GetFavouriteQuotes extends FavouritesEvent {}

class OnDeletePressed extends FavouritesEvent {
  final FavouriteEntity entity;
  const OnDeletePressed(this.entity);
}
