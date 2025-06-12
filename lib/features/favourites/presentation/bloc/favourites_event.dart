import 'package:sureline/features/home/domain/entity/quote_entity.dart';

abstract class FavouritesEvent {
  const FavouritesEvent();
}

class GetFavouriteQuotes extends FavouritesEvent {}

class OnDeletePressed extends FavouritesEvent{
  final QuoteEntity entity;
  const OnDeletePressed(this.entity);
}