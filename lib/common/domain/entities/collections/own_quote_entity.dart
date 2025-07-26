/// Own quote-related domain entities for the Sureline app.
///
/// This file contains the domain entity for handling user-created quotes
/// within the Sureline app. The [OwnQuoteEntity] represents a quote
/// that has been created by the user, with metadata about its creation
/// and favorite status.
///
/// Key Features:
/// - Immutable user-created quote data structure
/// - Creation timestamp tracking
/// - Favorite status tracking
/// - Collection association
/// - Factory method for model conversion
/// - CopyWith method for immutable updates
///
/// Usage:
/// ```dart
/// final ownQuote = OwnQuoteEntity(
///   id: 1,
///   quoteText: 'My personal motivational quote',
///   createdAt: '2024-01-01T00:00:00Z',
///   isFavourite: true,
///   collections: [...],
/// );
/// ```

import 'package:sureline/common/data/model/collections/own_quote_model.dart';
import 'package:sureline/common/domain/entities/collections/collection_entity.dart';

/// Entity representing a user-created quote.
///
/// This entity is used for managing quotes that users have created themselves.
/// It tracks the quote content, creation time, favorite status, and which
/// collections the quote belongs to.
///
/// Properties:
/// - [id]: Unique identifier for the user-created quote
/// - [quoteText]: The quote text content created by the user
/// - [createdAt]: When the quote was created
/// - [isFavourite]: Whether this quote is marked as favorite
/// - [collections]: List of collections this quote belongs to
///
/// The entity is immutable and provides factory methods for converting
/// from data models to domain entities, as well as a copyWith method
/// for creating modified instances.
class OwnQuoteEntity {
  /// Unique identifier for the user-created quote.
  ///
  /// Used to distinguish between different user-created quotes.
  final int id;

  /// The quote text content created by the user.
  ///
  /// Contains the inspirational or motivational quote text
  /// that the user has written themselves.
  final String quoteText;

  /// When the quote was created.
  ///
  /// ISO 8601 formatted timestamp string.
  final String createdAt;

  /// Whether this quote is marked as favorite.
  ///
  /// True if the user has marked this quote as one of their favorites.
  final bool isFavourite;

  /// List of collections this quote belongs to.
  ///
  /// Contains all collections that include this user-created quote.
  final List<CollectionEntity> collections;

  /// Creates an [OwnQuoteEntity] instance.
  ///
  /// All parameters are required to create a complete user-created quote.
  ///
  /// [id]: Unique identifier for the user-created quote
  /// [quoteText]: The quote text content
  /// [createdAt]: When the quote was created
  /// [collections]: List of collections this quote belongs to
  /// [isFavourite]: Whether this quote is marked as favorite
  OwnQuoteEntity({
    required this.id,
    required this.quoteText,
    required this.createdAt,
    required this.collections,
    required this.isFavourite,
  });

  /// Creates a copy of this entity with the given fields replaced by new values.
  ///
  /// This method allows for immutable updates by creating a new instance
  /// with only the specified fields changed.
  ///
  /// All parameters are optional. If not provided, the current value is used.
  /// Returns: A new [OwnQuoteEntity] instance with updated values
  OwnQuoteEntity copyWith({
    List<CollectionEntity>? collections,
    String? quoteText,
    String? createdAt,
    int? id,
    bool? isFavourite,
  }) {
    return OwnQuoteEntity(
      id: id ?? this.id,
      quoteText: quoteText ?? this.quoteText,
      createdAt: createdAt ?? this.createdAt,
      collections: collections ?? this.collections,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  /// Creates an [OwnQuoteEntity] from an [OwnQuoteModel].
  ///
  /// This factory method converts a data layer model to a domain entity,
  /// maintaining the separation between data and domain layers.
  /// It also converts all nested collection models to entities.
  ///
  /// [model]: The data model to convert from
  /// Returns: A new [OwnQuoteEntity] instance
  factory OwnQuoteEntity.fromModel(OwnQuoteModel model) {
    return OwnQuoteEntity(
      id: model.id,
      quoteText: model.quoteText,
      createdAt: model.createdAt,
      collections: model.collections.map((e) => CollectionEntity.fromModel(e)).toList(),
      isFavourite: model.isFavourite,
    );
  }
}
