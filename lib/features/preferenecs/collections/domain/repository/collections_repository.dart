/// Repository interface for collections management.
///
/// Defines operations for collection CRUD and quote-collection relationships.
/// This repository handles the business logic for organizing quotes into user-defined
/// collections, supporting multiple quote types (favourites, own quotes, history, search).
/// Collections provide a way for users to group related quotes for easy access
/// and organization.

import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/collection_entity.dart';
import 'package:sureline/common/domain/entities/collections/favourite_entity.dart';
import 'package:sureline/common/domain/entities/collections/history_entity.dart';
import 'package:sureline/common/domain/entities/collections/own_quote_entity.dart';
import 'package:sureline/common/domain/entities/collections/search_entity.dart';
import 'package:sureline/core/error/failures.dart';

/// Abstract repository for collections data operations.
///
/// Provides a clean interface for managing user collections and their relationships
/// with different types of quotes. Supports CRUD operations for collections and
/// bidirectional relationships between collections and quotes.
///
/// Key responsibilities:
/// - Collection lifecycle management (create, read, delete)
/// - Quote-collection relationship management
/// - Querying collections by quote type and vice versa
/// - Maintaining data consistency across quote types
abstract class CollectionsRepository {
  /// Retrieves all user collections with their associated quotes.
  ///
  /// Returns a list of collections populated with their favourite quotes,
  /// own quotes, history quotes, and search quotes. Each collection
  /// contains metadata about the quotes it contains.
  ///
  /// Returns: Either a failure or list of collections with populated quote data
  Future<Either<Failure, List<CollectionEntity>>> getCollections();

  /// Saves a new collection to persistent storage.
  ///
  /// Creates a new collection with the specified name and metadata.
  /// The collection is immediately available for adding quotes.
  ///
  /// [collection]: The collection entity to save
  /// Returns: Either a failure or void on success
  Future<Either<Failure, void>> saveCollection(CollectionEntity collection);

  /// Removes a collection and all its quote relationships.
  ///
  /// Deletes the collection and cleans up all associated quote-collection
  /// relationships. This operation is irreversible.
  ///
  /// [collection]: The collection entity to remove
  /// Returns: Either a failure or void on success
  Future<Either<Failure, void>> removeCollection(CollectionEntity collection);

  /// Adds a favourite quote to a collection.
  ///
  /// Creates a relationship between a favourite quote and a collection.
  /// The quote will appear in the collection's favourite quotes list.
  ///
  /// [collectionId]: The ID of the target collection
  /// [favouriteId]: The ID of the favourite quote to add
  /// Returns: Either a failure or void on success
  Future<Either<Failure, void>> addFavouriteQuoteToCollection(int collectionId, int favouriteId);

  /// Removes a favourite quote from a collection.
  ///
  /// Removes the relationship between a favourite quote and a collection.
  /// The quote remains in the user's favourites but is no longer in this collection.
  ///
  /// [collectionId]: The ID of the collection to remove from
  /// [favouriteId]: The ID of the favourite quote to remove
  /// Returns: Either a failure or void on success
  Future<Either<Failure, void>> removeFavouriteQuoteFromCollection(
    int collectionId,
    int favouriteId,
  );

  /// Gets all favourite quotes within a specific collection.
  ///
  /// Retrieves all favourite quotes that belong to the specified collection,
  /// including their metadata and relationships.
  ///
  /// [collectionId]: The ID of the collection to query
  /// Returns: Either a failure or list of favourite entities
  Future<Either<Failure, List<FavouriteEntity>>> getFavouritesOfCollection(int collectionId);

  /// Gets all collections containing a specific favourite quote.
  ///
  /// Retrieves all collections that include the specified favourite quote.
  /// Useful for showing which collections a quote belongs to.
  ///
  /// [favouriteId]: The ID of the favourite quote to query
  /// Returns: Either a failure or list of collection entities
  Future<Either<Failure, List<CollectionEntity>>> getCollectionsOfFavourite(int favouriteId);

  /// Adds an own quote to a collection.
  ///
  /// Creates a relationship between a user-created quote and a collection.
  /// The quote will appear in the collection's own quotes list.
  ///
  /// [collectionId]: The ID of the target collection
  /// [ownQuoteId]: The ID of the own quote to add
  /// Returns: Either a failure or void on success
  Future<Either<Failure, void>> addOwnQuoteToCollection(int collectionId, int ownQuoteId);

  /// Removes an own quote from a collection.
  ///
  /// Removes the relationship between an own quote and a collection.
  /// The quote remains in the user's own quotes but is no longer in this collection.
  ///
  /// [collectionId]: The ID of the collection to remove from
  /// [ownQuoteId]: The ID of the own quote to remove
  /// Returns: Either a failure or void on success
  Future<Either<Failure, void>> removeOwnQuoteFromCollection(int collectionId, int ownQuoteId);

  /// Gets all own quotes within a specific collection.
  ///
  /// Retrieves all user-created quotes that belong to the specified collection,
  /// including their metadata and relationships.
  ///
  /// [collectionId]: The ID of the collection to query
  /// Returns: Either a failure or list of own quote entities
  Future<Either<Failure, List<OwnQuoteEntity>>> getOwnQuotesOfCollection(int collectionId);

  /// Gets all collections containing a specific own quote.
  ///
  /// Retrieves all collections that include the specified own quote.
  /// Useful for showing which collections a quote belongs to.
  ///
  /// [ownQuoteId]: The ID of the own quote to query
  /// Returns: Either a failure or list of collection entities
  Future<Either<Failure, List<CollectionEntity>>> getCollectionsOfOwnQuote(int ownQuoteId);

  /// Adds a history quote to a collection.
  ///
  /// Creates a relationship between a history quote and a collection.
  /// The quote will appear in the collection's history quotes list.
  ///
  /// [collectionId]: The ID of the target collection
  /// [quoteId]: The ID of the history quote to add
  /// Returns: Either a failure or void on success
  Future<Either<Failure, void>> addHistoryToCollection(int collectionId, int quoteId);

  /// Removes a history quote from a collection.
  ///
  /// Removes the relationship between a history quote and a collection.
  /// The quote remains in the user's history but is no longer in this collection.
  ///
  /// [collectionId]: The ID of the collection to remove from
  /// [quoteId]: The ID of the history quote to remove
  /// Returns: Either a failure or void on success
  Future<Either<Failure, void>> removeHistoryFromCollection(int collectionId, int quoteId);

  /// Gets all collections containing a specific history quote.
  ///
  /// Retrieves all collections that include the specified history quote.
  /// Useful for showing which collections a quote belongs to.
  ///
  /// [historyId]: The ID of the history quote to query
  /// Returns: Either a failure or list of collection entities
  Future<Either<Failure, List<CollectionEntity>>> getCollectionsOfHistory(int historyId);

  /// Gets all history quotes within a specific collection.
  ///
  /// Retrieves all history quotes that belong to the specified collection,
  /// including their metadata and relationships.
  ///
  /// [collectionId]: The ID of the collection to query
  /// Returns: Either a failure or list of history entities
  Future<Either<Failure, List<HistoryEntity>>> getHistoryOfCollection(int collectionId);

  /// Adds a search quote to a collection.
  ///
  /// Creates a relationship between a search quote and a collection.
  /// The quote will appear in the collection's search quotes list.
  ///
  /// [collectionId]: The ID of the target collection
  /// [searchId]: The ID of the search quote to add
  /// Returns: Either a failure or void on success
  Future<Either<Failure, void>> addSearchToCollection(int collectionId, int searchId);

  /// Removes a search quote from a collection.
  ///
  /// Removes the relationship between a search quote and a collection.
  /// The quote remains in the user's search results but is no longer in this collection.
  ///
  /// [collectionId]: The ID of the collection to remove from
  /// [searchId]: The ID of the search quote to remove
  /// Returns: Either a failure or void on success
  Future<Either<Failure, void>> removeSearchFromCollection(int collectionId, int searchId);

  /// Gets all collections containing a specific search quote.
  ///
  /// Retrieves all collections that include the specified search quote.
  /// Useful for showing which collections a quote belongs to.
  ///
  /// [searchId]: The ID of the search quote to query
  /// Returns: Either a failure or list of collection entities
  Future<Either<Failure, List<CollectionEntity>>> getCollectionsOfSearch(int searchId);

  /// Gets all search quotes within a specific collection.
  ///
  /// Retrieves all search quotes that belong to the specified collection,
  /// including their metadata and relationships.
  ///
  /// [collectionId]: The ID of the collection to query
  /// [isPremium]: Whether the user has premium access
  /// Returns: Either a failure or list of search entities
  Future<Either<Failure, List<SearchEntity>>> getSearchOfCollection(
    int collectionId, {
    required bool isPremium,
  });
}
