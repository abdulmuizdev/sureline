/// States for collections management.
///
/// Represents different states of collection operations and data.
/// These states represent the various UI states and data conditions
/// that can occur during collections management, including loading,
/// success, and error states for different operations.

import 'package:sureline/common/domain/entities/collections/collection_entity.dart';
import 'package:sureline/common/domain/entities/collections/favourite_entity.dart';
import 'package:sureline/common/domain/entities/collections/history_entity.dart';
import 'package:sureline/common/domain/entities/collections/own_quote_entity.dart';
import 'package:sureline/common/domain/entities/collections/search_entity.dart';

/// Base class for all collection states.
///
/// Provides a common interface for all collection-related states.
/// This abstract class ensures type safety and consistent state handling
/// across the collections bloc.
abstract class CollectionsState {
  const CollectionsState();
}

/// Initial state.
///
/// Represents the default state before any collections operations.
/// This state is typically shown when the collections feature is first loaded
/// or when the bloc is reset.
class Initial extends CollectionsState {}

/// Collections loaded successfully.
///
/// Represents the state when all user collections have been successfully
/// retrieved from the database. This state contains the complete list
/// of collections with their associated quotes.
///
/// [collections]: The list of collections with populated quote data
class GotCollections extends CollectionsState {
  final List<CollectionEntity>? collections;
  const GotCollections(this.collections);
}

/// Favourites of a collection loaded.
///
/// Represents the state when favourite quotes within a specific collection
/// have been successfully retrieved. This state is used when viewing
/// collection details or managing favourites within a collection.
///
/// [favourites]: The list of favourite entities in the collection
class GotFavouritesOfCollection extends CollectionsState {
  final List<FavouriteEntity>? favourites;
  const GotFavouritesOfCollection(this.favourites);
}

/// Own quotes of a collection loaded.
///
/// Represents the state when user-created quotes within a specific collection
/// have been successfully retrieved. This state is used when viewing
/// collection details or managing own quotes within a collection.
///
/// [ownQuotes]: The list of own quote entities in the collection
class GotOwnQuotesOfCollection extends CollectionsState {
  final List<OwnQuoteEntity>? ownQuotes;
  const GotOwnQuotesOfCollection(this.ownQuotes);
}

/// History quotes of a collection loaded.
///
/// Represents the state when history quotes within a specific collection
/// have been successfully retrieved. This state is used when viewing
/// collection details or managing history quotes within a collection.
///
/// [history]: The list of history entities in the collection
class GotHistoryOfCollection extends CollectionsState {
  final List<HistoryEntity>? history;
  const GotHistoryOfCollection(this.history);
}

/// Search quotes of a collection loaded.
///
/// Represents the state when search quotes within a specific collection
/// have been successfully retrieved. This state is used when viewing
/// collection details or managing search quotes within a collection.
///
/// [search]: The list of search entities in the collection
class GotSearchOfCollection extends CollectionsState {
  final List<SearchEntity>? search;
  const GotSearchOfCollection(this.search);
}

/// Collections containing a favourite loaded.
///
/// Represents the state when all collections containing a specific favourite
/// quote have been successfully retrieved. This state is useful for showing
/// which collections a quote belongs to or for collection selection dialogs.
///
/// [collections]: The list of collections containing the favourite
class GotCollectionsOfFavourite extends CollectionsState {
  final List<CollectionEntity>? collections;
  const GotCollectionsOfFavourite(this.collections);
}

/// Collections containing an own quote loaded.
///
/// Represents the state when all collections containing a specific own quote
/// have been successfully retrieved. This state is useful for showing
/// which collections a quote belongs to or for collection selection dialogs.
///
/// [collections]: The list of collections containing the own quote
class GotCollectionsOfOwnQuote extends CollectionsState {
  final List<CollectionEntity>? collections;
  const GotCollectionsOfOwnQuote(this.collections);
}

/// Collections containing a history quote loaded.
///
/// Represents the state when all collections containing a specific history quote
/// have been successfully retrieved. This state is useful for showing
/// which collections a quote belongs to or for collection selection dialogs.
///
/// [collections]: The list of collections containing the history quote
class GotCollectionsOfHistory extends CollectionsState {
  final List<CollectionEntity>? collections;
  const GotCollectionsOfHistory(this.collections);
}

/// Collections containing a search quote loaded.
///
/// Represents the state when all collections containing a specific search quote
/// have been successfully retrieved. This state is useful for showing
/// which collections a quote belongs to or for collection selection dialogs.
///
/// [collections]: The list of collections containing the search quote
class GotCollectionsOfSearch extends CollectionsState {
  final List<CollectionEntity>? collections;
  const GotCollectionsOfSearch(this.collections);
}

/// Combined state: favourites and their collections.
///
/// Represents a combined state containing both favourite quotes and the
/// collections they belong to. This state is useful for complex UI scenarios
/// where both pieces of data are needed simultaneously.
///
/// [favourites]: The list of favourite entities
/// [collections]: The list of collections containing the favourites
class GotFavouritesOfCollectionAndCollectionsOfFavourite extends CollectionsState {
  final List<FavouriteEntity> favourites;
  final List<CollectionEntity> collections;
  const GotFavouritesOfCollectionAndCollectionsOfFavourite(this.favourites, this.collections);
}

/// Combined state: own quotes and their collections.
///
/// Represents a combined state containing both own quotes and the
/// collections they belong to. This state is useful for complex UI scenarios
/// where both pieces of data are needed simultaneously.
///
/// [ownQuotes]: The list of own quote entities
/// [collections]: The list of collections containing the own quotes
class GotOwnQuotesOfCollectionAndCollectionsOfOwnQuote extends CollectionsState {
  final List<OwnQuoteEntity> ownQuotes;
  final List<CollectionEntity> collections;
  const GotOwnQuotesOfCollectionAndCollectionsOfOwnQuote(this.ownQuotes, this.collections);
}

/// Combined state: history quotes and their collections.
///
/// Represents a combined state containing both history quotes and the
/// collections they belong to. This state is useful for complex UI scenarios
/// where both pieces of data are needed simultaneously.
///
/// [history]: The list of history entities
/// [collections]: The list of collections containing the history quotes
class GotHistoryOfCollectionAndCollectionsOfHistory extends CollectionsState {
  final List<HistoryEntity> history;
  final List<CollectionEntity> collections;
  const GotHistoryOfCollectionAndCollectionsOfHistory(this.history, this.collections);
}

/// Combined state: search quotes and their collections.
///
/// Represents a combined state containing both search quotes and the
/// collections they belong to. This state is useful for complex UI scenarios
/// where both pieces of data are needed simultaneously.
///
/// [search]: The list of search entities
/// [collections]: The list of collections containing the search quotes
class GotSearchOfCollectionAndCollectionsOfSearch extends CollectionsState {
  final List<SearchEntity> search;
  final List<CollectionEntity> collections;
  const GotSearchOfCollectionAndCollectionsOfSearch(this.search, this.collections);
}

/// Collection saved successfully.
///
/// Represents the state when a new collection has been successfully created
/// and saved to the database. This state includes the updated list of
/// collections to refresh the UI.
///
/// [collections]: The updated list of collections after saving
class SavedCollection extends CollectionsState {
  final List<CollectionEntity> collections;
  const SavedCollection(this.collections);
}
