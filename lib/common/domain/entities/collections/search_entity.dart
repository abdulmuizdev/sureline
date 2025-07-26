/// Search-related domain entities for the Sureline app.
///
/// This file contains the domain entity for handling search results
/// within the Sureline app. The [SearchEntity] represents a quote
/// that has been returned as a search result, with metadata about
/// its favorite status and collection associations.
///
/// Key Features:
/// - Immutable search result data structure
/// - Favorite status tracking
/// - Collection association
/// - Factory method for model conversion
/// - CopyWith method for immutable updates
///
/// Usage:
/// ```dart
/// final searchResult = SearchEntity(
///   id: 1,
///   quoteText: 'A quote matching the search query',
///   isFavourite: true,
///   collections: [...],
/// );
/// ```

import 'package:sureline/common/data/model/collections/search_model.dart';
import 'package:sureline/common/domain/entities/collections/collection_entity.dart';

/// Domain entity representing a search result.
///
/// This entity is used for managing quotes that have been returned
/// as search results based on user queries. It tracks the quote content,
/// favorite status, and which collections the quote belongs to.
///
/// Properties:
/// - [id]: Unique identifier for the search result
/// - [quoteText]: The quote text content from search results
/// - [isFavourite]: Whether this quote is marked as favorite
/// - [collections]: List of collections this quote belongs to
///
/// The entity is immutable and provides factory methods for converting
/// from data models to domain entities, as well as a copyWith method
/// for creating modified instances.
class SearchEntity {
  /// The unique identifier of the search result.
  ///
  /// Used to distinguish between different search result entries.
  final int id;

  /// The quote text content.
  ///
  /// Contains the inspirational or motivational quote text
  /// that matches the user's search query.
  final String quoteText;

  /// Whether the quote is marked as favourite.
  ///
  /// True if the user has marked this quote as one of their favorites.
  final bool isFavourite;

  /// List of collections this quote belongs to.
  ///
  /// Contains all collections that include this search result quote.
  final List<CollectionEntity> collections;

  /// Creates a new SearchEntity instance.
  ///
  /// All parameters are required to create a complete search result.
  ///
  /// [id]: Unique identifier for the search result
  /// [quoteText]: The quote text content
  /// [isFavourite]: Whether this quote is marked as favorite
  /// [collections]: List of collections this quote belongs to
  const SearchEntity({
    required this.id,
    required this.quoteText,
    required this.isFavourite,
    required this.collections,
  });

  /// Creates a copy of this entity with updated values.
  ///
  /// This method allows for immutable updates by creating a new instance
  /// with only the specified fields changed.
  ///
  /// All parameters are optional. If not provided, the current value is used.
  /// Returns: A new [SearchEntity] instance with updated values
  SearchEntity copyWith({
    int? id,
    String? quoteText,
    bool? isFavourite,
    List<CollectionEntity>? collections,
  }) {
    return SearchEntity(
      id: id ?? this.id,
      quoteText: quoteText ?? this.quoteText,
      isFavourite: isFavourite ?? this.isFavourite,
      collections: collections ?? this.collections,
    );
  }

  /// Creates a SearchEntity from a SearchModel.
  ///
  /// This factory method converts a data layer model to a domain entity,
  /// maintaining the separation between data and domain layers.
  /// It also converts all nested collection models to entities.
  ///
  /// [model]: The data model to convert from
  /// Returns: A new [SearchEntity] instance
  factory SearchEntity.fromModel(SearchModel model) {
    return SearchEntity(
      id: model.id,
      quoteText: model.quoteText,
      isFavourite: model.isFavourite,
      collections: model.collections.map((e) => CollectionEntity.fromModel(e)).toList(),
    );
  }
}
