/// Collection-related domain entities for the Sureline app.
///
/// This file contains the domain entity for handling collection data
/// within the Sureline app. The [CollectionEntity] represents a user's
/// collection of quotes, including favorites, own quotes, history,
/// and search results.
///
/// Key Features:
/// - Immutable collection data structure
/// - Support for multiple quote types (favorites, own, history, search)
/// - Factory method for model conversion
/// - Organized quote management
///
/// Usage:
/// ```dart
/// final collection = CollectionEntity(
///   id: 1,
///   name: 'My Collection',
///   favouriteQuotes: [...],
///   ownQuotes: [...],
///   historyQuotes: [...],
///   searchQuotes: [...],
/// );
/// ```

import 'package:sureline/common/data/model/collections/collection_model.dart';
import 'package:sureline/common/domain/entities/collections/favourite_entity.dart';
import 'package:sureline/common/domain/entities/collections/history_entity.dart';
import 'package:sureline/common/domain/entities/collections/own_quote_entity.dart';
import 'package:sureline/common/domain/entities/collections/search_entity.dart';

/// Entity representing a user's collection of quotes.
///
/// This entity is used for managing and organizing different types of quotes
/// that a user has interacted with. It provides a centralized way to access
/// favorites, own quotes, browsing history, and search results.
///
/// Properties:
/// - [id]: Unique identifier for the collection
/// - [name]: Display name for the collection
/// - [favouriteQuotes]: List of quotes marked as favorites
/// - [ownQuotes]: List of quotes created by the user
/// - [historyQuotes]: List of quotes from browsing history
/// - [searchQuotes]: List of quotes from search results
///
/// The entity is immutable and provides factory methods for converting
/// from data models to domain entities.
class CollectionEntity {
  /// Unique identifier for the collection.
  ///
  /// Used to distinguish between different collections or user accounts.
  final int id;

  /// Display name for the collection.
  ///
  /// Human-readable name that identifies this collection.
  final String name;

  /// List of quotes marked as favorites.
  ///
  /// Contains quotes that the user has marked as their favorites
  /// for quick access and personal curation.
  final List<FavouriteEntity> favouriteQuotes;

  /// List of quotes created by the user.
  ///
  /// Contains quotes that the user has written or created themselves.
  final List<OwnQuoteEntity> ownQuotes;

  /// List of quotes from browsing history.
  ///
  /// Contains quotes that the user has viewed or interacted with
  /// during their browsing sessions.
  final List<HistoryEntity> historyQuotes;

  /// List of quotes from search results.
  ///
  /// Contains quotes that match the user's search queries
  /// and are displayed as search results.
  final List<SearchEntity> searchQuotes;

  /// Creates a [CollectionEntity] instance.
  ///
  /// All parameters are required to create a complete collection.
  ///
  /// [id]: Unique identifier for the collection
  /// [name]: Display name for the collection
  /// [favouriteQuotes]: List of favorite quotes
  /// [ownQuotes]: List of user-created quotes
  /// [historyQuotes]: List of history quotes
  /// [searchQuotes]: List of search result quotes
  CollectionEntity({
    required this.id,
    required this.name,
    required this.favouriteQuotes,
    required this.ownQuotes,
    required this.historyQuotes,
    required this.searchQuotes,
  });

  /// Creates a [CollectionEntity] from a [CollectionModel].
  ///
  /// This factory method converts a data layer model to a domain entity,
  /// maintaining the separation between data and domain layers.
  /// It also converts all nested quote models to their respective entities.
  ///
  /// [model]: The data model to convert from
  /// Returns: A new [CollectionEntity] instance
  factory CollectionEntity.fromModel(CollectionModel model) {
    return CollectionEntity(
      id: model.id,
      name: model.name,
      favouriteQuotes: model.favouriteQuotes.map((e) => FavouriteEntity.fromModel(e)).toList(),
      ownQuotes: model.ownQuotes.map((e) => OwnQuoteEntity.fromModel(e)).toList(),
      historyQuotes: model.historyQuotes.map((e) => HistoryEntity.fromModel(e)).toList(),
      searchQuotes: model.searchQuotes.map((e) => SearchEntity.fromModel(e)).toList(),
    );
  }
}
