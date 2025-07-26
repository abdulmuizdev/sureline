/// Favourite-related domain entities for the Sureline app.
///
/// This file contains the domain entity for handling favorite quotes
/// within the Sureline app. The [FavouriteEntity] represents a quote
/// that has been marked as a favorite by the user, with references
/// to its original source and associated collections.
///
/// Key Features:
/// - Immutable favorite quote data structure
/// - Support for multiple source references (quote, own quote, history, search)
/// - Collection association tracking
/// - Factory method for model conversion
/// - CopyWith method for immutable updates
///
/// Usage:
/// ```dart
/// final favourite = FavouriteEntity(
///   id: 1,
///   quote: 'Be the change you wish to see in the world.',
///   quoteId: 123,
///   createdAt: '2024-01-01T00:00:00Z',
///   collections: [...],
/// );
/// ```

import 'package:sureline/common/data/model/collections/favourite_model.dart';
import 'package:sureline/common/domain/entities/collections/collection_entity.dart';

/// Entity representing a favorite quote.
///
/// This entity is used for managing quotes that users have marked as favorites.
/// It maintains references to the original source of the quote (whether from
/// the main quote database, user's own quotes, history, or search results)
/// and tracks which collections the favorite belongs to.
///
/// Properties:
/// - [id]: Unique identifier for the favorite entry
/// - [quote]: The actual quote text content
/// - [quoteId]: Reference to the original quote (if from main database)
/// - [ownQuoteId]: Reference to user's own quote (if from user-created quotes)
/// - [historyId]: Reference to history entry (if from browsing history)
/// - [searchId]: Reference to search result (if from search)
/// - [createdAt]: When the quote was marked as favorite
/// - [collections]: List of collections this favorite belongs to
///
/// The entity is immutable and provides factory methods for converting
/// from data models to domain entities, as well as a copyWith method
/// for creating modified instances.
class FavouriteEntity {
  /// Unique identifier for the favorite entry.
  ///
  /// Used to distinguish between different favorite entries.
  final int id;

  /// The actual quote text content.
  ///
  /// Contains the inspirational or motivational quote text.
  final String quote;

  /// Reference to the original quote from the main database.
  ///
  /// Null if the favorite is not from the main quote database.
  final int? quoteId;

  /// Reference to user's own quote.
  ///
  /// Null if the favorite is not from user-created quotes.
  final int? ownQuoteId;

  /// Reference to history entry.
  ///
  /// Null if the favorite is not from browsing history.
  final int? historyId;

  /// Reference to search result.
  ///
  /// Null if the favorite is not from search results.
  final int? searchId;

  /// When the quote was marked as favorite.
  ///
  /// ISO 8601 formatted timestamp string.
  final String createdAt;

  /// List of collections this favorite belongs to.
  ///
  /// Contains all collections that include this favorite quote.
  final List<CollectionEntity> collections;

  /// Creates a [FavouriteEntity] instance.
  ///
  /// [id], [quote], [createdAt], and [collections] are required.
  /// The ID references are optional and depend on the source of the quote.
  ///
  /// [id]: Unique identifier for the favorite entry
  /// [quote]: The quote text content
  /// [quoteId]: Reference to original quote (optional)
  /// [ownQuoteId]: Reference to user's own quote (optional)
  /// [historyId]: Reference to history entry (optional)
  /// [searchId]: Reference to search result (optional)
  /// [createdAt]: When the quote was marked as favorite
  /// [collections]: List of collections this favorite belongs to
  FavouriteEntity({
    required this.id,
    required this.quote,
    this.quoteId,
    this.ownQuoteId,
    this.historyId,
    this.searchId,
    required this.createdAt,
    required this.collections,
  });

  /// Creates a [FavouriteEntity] from a [FavouriteModel].
  ///
  /// This factory method converts a data layer model to a domain entity,
  /// maintaining the separation between data and domain layers.
  /// It also converts all nested collection models to entities.
  ///
  /// [model]: The data model to convert from
  /// Returns: A new [FavouriteEntity] instance
  factory FavouriteEntity.fromModel(FavouriteModel model) {
    return FavouriteEntity(
      id: model.id,
      quote: model.quote,
      quoteId: model.quoteId,
      ownQuoteId: model.ownQuoteId,
      historyId: model.historyId,
      searchId: model.searchId,
      createdAt: model.createdAt,
      collections: model.collections.map((e) => CollectionEntity.fromModel(e)).toList(),
    );
  }

  /// Creates a copy of this entity with the given fields replaced by new values.
  ///
  /// This method allows for immutable updates by creating a new instance
  /// with only the specified fields changed.
  ///
  /// All parameters are optional. If not provided, the current value is used.
  /// Returns: A new [FavouriteEntity] instance with updated values
  FavouriteEntity copyWith({
    int? id,
    String? quote,
    int? quoteId,
    int? ownQuoteId,
    int? searchId,
    String? createdAt,
    List<CollectionEntity>? collections,
  }) {
    return FavouriteEntity(
      id: id ?? this.id,
      quote: quote ?? this.quote,
      quoteId: quoteId ?? this.quoteId,
      ownQuoteId: ownQuoteId ?? this.ownQuoteId,
      searchId: searchId ?? this.searchId,
      createdAt: createdAt ?? this.createdAt,
      collections: collections ?? this.collections,
    );
  }
}
