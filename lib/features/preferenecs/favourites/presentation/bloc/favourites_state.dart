import 'package:sureline/common/domain/entities/collections/favourite_entity.dart';

/// Abstract base class for all favourites-related states.
///
/// States represent the different UI states that the favourites feature
/// can be in, from initial loading to displaying data or error states.
abstract class FavouritesState {
  const FavouritesState();
}

/// Initial state when the favourites feature is first loaded.
///
/// This state is emitted when the FavouritesBloc is first created
/// and no data has been loaded yet. The UI should show a loading
/// indicator or empty state.
class Initial extends FavouritesState {}

/// State when favourite quotes have been successfully loaded.
///
/// This state is emitted after successfully retrieving favourite quotes
/// from the data source. The UI should display the list of favourite
/// quotes with appropriate interactions.
///
/// [quotes] - List of favourite quote entities to display
class GotFavouriteQuotes extends FavouritesState {
  final List<FavouriteEntity>? quotes;
  const GotFavouriteQuotes(this.quotes);
}
