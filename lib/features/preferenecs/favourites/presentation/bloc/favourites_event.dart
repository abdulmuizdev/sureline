import 'package:sureline/common/domain/entities/collections/favourite_entity.dart';

/// Abstract base class for all favourites-related events.
///
/// Events are dispatched to the FavouritesBloc to trigger state changes
/// and business logic operations in the favourites feature.
abstract class FavouritesEvent {
  const FavouritesEvent();
}

/// Event to retrieve all favourite quotes from the data source.
///
/// This event triggers the loading of all user's favourite quotes,
/// typically called when the favourites screen is first opened.
/// The bloc will emit GotFavouriteQuotes state with the loaded quotes.
class GetFavouriteQuotes extends FavouritesEvent {}

/// Event triggered when user requests to delete a favourite quote.
///
/// This event is dispatched when the user confirms deletion of a favourite
/// quote. The bloc will remove the quote from favourites and refresh
/// the list to reflect the changes.
///
/// [entity] - The favourite quote entity to be deleted
class OnDeletePressed extends FavouritesEvent {
  final FavouriteEntity entity;
  const OnDeletePressed(this.entity);
}
