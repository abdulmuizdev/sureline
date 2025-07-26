/// Events for collections management.
///
/// Handles collection CRUD operations and quote-collection relationships.
/// These events represent user actions and system triggers for collections
/// management, including creating, deleting, and managing quote relationships
/// across different quote types (favourites, own quotes, history, search).

import 'package:sureline/common/domain/entities/collections/collection_entity.dart';

/// Base class for all collection events.
///
/// Provides a common interface for all collection-related events.
/// This abstract class ensures type safety and consistent event handling
/// across the collections bloc.
abstract class CollectionsEvent {
  const CollectionsEvent();
}

/// Fetches all user collections.
///
/// Triggers the retrieval of all user collections with their associated quotes.
/// This event is typically dispatched when the collections page loads or when
/// collections need to be refreshed after CRUD operations.
class GetCollections extends CollectionsEvent {}

/// Retrieves favourites within a specific collection.
///
/// Fetches all favourite quotes that belong to the specified collection.
/// This event is used when viewing a collection's details or managing
/// favourite quotes within a collection.
///
/// [id]: The ID of the collection to query for favourites
class GetFavouritesOfCollection extends CollectionsEvent {
  final int id;
  const GetFavouritesOfCollection(this.id);
}

/// Retrieves own quotes within a specific collection.
///
/// Fetches all user-created quotes that belong to the specified collection.
/// This event is used when viewing a collection's details or managing
/// own quotes within a collection.
///
/// [id]: The ID of the collection to query for own quotes
class GetOwnQuotesOfCollection extends CollectionsEvent {
  final int id;
  const GetOwnQuotesOfCollection(this.id);
}

/// Retrieves history quotes within a specific collection.
///
/// Fetches all history quotes that belong to the specified collection.
/// This event is used when viewing a collection's details or managing
/// history quotes within a collection.
///
/// [collectionId]: The ID of the collection to query for history quotes
class GetHistoryOfCollection extends CollectionsEvent {
  final int collectionId;
  const GetHistoryOfCollection(this.collectionId);
}

/// Retrieves search quotes within a specific collection.
///
/// Fetches all search quotes that belong to the specified collection.
/// This event is used when viewing a collection's details or managing
/// search quotes within a collection.
///
/// [collectionId]: The ID of the collection to query for search quotes
class GetSearchOfCollection extends CollectionsEvent {
  final int collectionId;
  const GetSearchOfCollection(this.collectionId);
}

/// Deletes a collection.
///
/// Triggers the deletion of a collection and all its associated quote relationships.
/// This event is typically dispatched when the user confirms collection deletion
/// from the UI.
///
/// [entity]: The collection entity to delete
class OnDeletePressed extends CollectionsEvent {
  final CollectionEntity entity;
  const OnDeletePressed(this.entity);
}

/// Saves a new collection.
///
/// Triggers the creation of a new collection with the specified name and metadata.
/// This event is typically dispatched when the user creates a new collection
/// from the UI.
///
/// [entity]: The collection entity to save
class SaveCollection extends CollectionsEvent {
  final CollectionEntity entity;
  const SaveCollection(this.entity);
}

/// Removes a quote from a collection.
///
/// Removes a specific quote from a collection while keeping the quote
/// in its original location (favourites, history, etc.).
///
/// [favouriteId]: The ID of the favourite quote to remove
/// [collectionId]: The ID of the collection to remove from
class OnDeleteQuotePressed extends CollectionsEvent {
  final int favouriteId;
  final int collectionId;
  const OnDeleteQuotePressed(this.favouriteId, this.collectionId);
}

/// Gets collections containing a specific favourite.
///
/// Fetches all collections that include the specified favourite quote.
/// This event is useful for showing which collections a quote belongs to
/// or for collection selection dialogs.
///
/// [favouriteId]: The ID of the favourite quote to query
class GetCollectionsOfFavourite extends CollectionsEvent {
  final int favouriteId;
  const GetCollectionsOfFavourite(this.favouriteId);
}

/// Gets collections containing a specific own quote.
///
/// Fetches all collections that include the specified own quote.
/// This event is useful for showing which collections a quote belongs to
/// or for collection selection dialogs.
///
/// [ownQuoteId]: The ID of the own quote to query
class GetCollectionsOfOwnQuote extends CollectionsEvent {
  final int ownQuoteId;
  const GetCollectionsOfOwnQuote(this.ownQuoteId);
}

/// Gets collections containing a specific history quote.
///
/// Fetches all collections that include the specified history quote.
/// This event is useful for showing which collections a quote belongs to
/// or for collection selection dialogs.
///
/// [quoteId]: The ID of the history quote to query
class GetCollectionsOfHistory extends CollectionsEvent {
  final int quoteId;
  const GetCollectionsOfHistory(this.quoteId);
}

/// Gets collections containing a specific search quote.
///
/// Fetches all collections that include the specified search quote.
/// This event is useful for showing which collections a quote belongs to
/// or for collection selection dialogs.
///
/// [searchId]: The ID of the search quote to query
class GetCollectionsOfSearch extends CollectionsEvent {
  final int searchId;
  const GetCollectionsOfSearch(this.searchId);
}

/// Adds or removes a quote from a collection.
///
/// Toggles the relationship between a quote and a collection based on the
/// current selection state. This event handles all quote types (favourites,
/// own quotes, history, search) and determines the appropriate action based
/// on the provided parameters.
///
/// [collectionId]: The ID of the target collection
/// [isSelected]: Whether the quote should be added (true) or removed (false)
/// [favouriteId]: The ID of the favourite quote (if applicable)
/// [ownQuoteId]: The ID of the own quote (if applicable)
/// [quoteId]: The ID of the history quote (if applicable)
/// [searchId]: The ID of the search quote (if applicable)
class OnAddToCollectionPressed extends CollectionsEvent {
  final int collectionId;
  final int? favouriteId;
  final int? ownQuoteId;
  final int? quoteId;
  final int? searchId;
  final bool isSelected;

  const OnAddToCollectionPressed({
    required this.collectionId,
    required this.isSelected,
    this.favouriteId,
    this.ownQuoteId,
    this.quoteId,
    this.searchId,
  });
}
