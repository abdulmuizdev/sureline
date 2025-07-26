/// History-related domain entities for the Sureline app.
///
/// This file contains the domain entity for handling quote history
/// within the Sureline app. The [HistoryEntity] represents a quote
/// that has been viewed or interacted with by the user, with metadata
/// about its favorite status and collection associations.
///
/// Key Features:
/// - Immutable history quote data structure
/// - Favorite status tracking
/// - Collection association
/// - Factory method for model conversion
/// - CopyWith method for immutable updates
///
/// Usage:
/// ```dart
/// final historyQuote = HistoryEntity(
///   id: 1,
///   quoteText: 'A quote from browsing history',
///   isFavourite: false,
///   collections: [...],
/// );
/// ```

import 'package:sureline/common/data/model/collections/history_model.dart';
import 'package:sureline/common/domain/entities/collections/collection_entity.dart';

/// Entity representing a quote from browsing history.
///
/// This entity is used for managing quotes that users have viewed
/// or interacted with during their browsing sessions. It tracks the
/// quote content, favorite status, and which collections the quote
/// belongs to.
///
/// Properties:
/// - [id]: Unique identifier for the history entry
/// - [quoteText]: The quote text content from browsing history
/// - [isFavourite]: Whether this quote is marked as favorite
/// - [collections]: List of collections this quote belongs to
///
/// The entity is immutable and provides factory methods for converting
/// from data models to domain entities, as well as a copyWith method
/// for creating modified instances.
class HistoryEntity {
  /// Unique identifier for the history entry.
  ///
  /// Used to distinguish between different history entries.
  final int id;

  /// The quote text content from browsing history.
  ///
  /// Contains the inspirational or motivational quote text
  /// that the user has viewed or interacted with.
  final String quoteText;

  /// Whether this quote is marked as favorite.
  ///
  /// True if the user has marked this quote as one of their favorites.
  final bool isFavourite;

  /// List of collections this quote belongs to.
  ///
  /// Contains all collections that include this history quote.
  final List<CollectionEntity> collections;

  /// Creates a [HistoryEntity] instance.
  ///
  /// All parameters are required to create a complete history entry.
  ///
  /// [id]: Unique identifier for the history entry
  /// [quoteText]: The quote text content
  /// [isFavourite]: Whether this quote is marked as favorite
  /// [collections]: List of collections this quote belongs to
  HistoryEntity({
    required this.id,
    required this.quoteText,
    required this.isFavourite,
    required this.collections,
  });

  /// Creates a copy of this entity with the given fields replaced by new values.
  ///
  /// This method allows for immutable updates by creating a new instance
  /// with only the specified fields changed.
  ///
  /// All parameters are optional. If not provided, the current value is used.
  /// Returns: A new [HistoryEntity] instance with updated values
  HistoryEntity copyWith({
    int? id,
    String? quoteText,
    bool? isFavourite,
    List<CollectionEntity>? collections,
  }) {
    return HistoryEntity(
      id: id ?? this.id,
      quoteText: quoteText ?? this.quoteText,
      isFavourite: isFavourite ?? this.isFavourite,
      collections: collections ?? this.collections,
    );
  }

  /// Creates a [HistoryEntity] from a [HistoryModel].
  ///
  /// This factory method converts a data layer model to a domain entity,
  /// maintaining the separation between data and domain layers.
  /// It also converts all nested collection models to entities.
  ///
  /// [model]: The data model to convert from
  /// Returns: A new [HistoryEntity] instance
  factory HistoryEntity.fromModel(HistoryModel model) {
    return HistoryEntity(
      id: model.id,
      quoteText: model.quoteText,
      isFavourite: model.isFavourite,
      collections: model.collections.map((e) => CollectionEntity.fromModel(e)).toList(),
    );
  }
}
