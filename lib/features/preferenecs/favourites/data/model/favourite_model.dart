import 'package:drift/drift.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/features/preferenecs/collections/data/model/collection_model.dart';
import 'package:sureline/features/preferenecs/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/preferenecs/history/data/model/history_model.dart';
import 'package:sureline/features/preferenecs/own_quotes/data/model/own_quote_model.dart';
import 'package:sureline/features/recommendation_algorithm/data/model/quote_model.dart';
import 'package:sureline/features/preferenecs/search/data/model/search_model.dart';

class FavouriteModel extends FavouriteEntity {
  final List<CollectionModel> collections;
  FavouriteModel({
    required super.id,
    required super.quote,
    required super.quoteId,
    required super.ownQuoteId,
    required super.historyId,
    required super.searchId,
    required super.createdAt,
    required this.collections,
  }) : super(collections: collections);

  /// Convert FavouriteModel to FavouritesCompanion for database operations
  FavouritesCompanion toFavouritesCompanion() {
    return FavouritesCompanion(
      id: id == 0 ? const Value.absent() : Value(id),
      quote: Value(quote),
      quoteId: Value(quoteId),
      ownQuoteId: Value(ownQuoteId),
      historyId: Value(historyId),
      searchId: Value(searchId),
      createdAt: Value(createdAt),
    );
  }

  /// Static method to create FavouritesCompanion from FavouriteModel
  static FavouritesCompanion fromFavouriteModel(FavouriteModel model) {
    return model.toFavouritesCompanion();
  }

  /// Factory method to create FavouriteModel from QuoteModel
  factory FavouriteModel.fromQuoteModel(QuoteModel model) {
    return FavouriteModel(
      id: 0, // Will be set by database auto-increment
      quote: model.quoteText,
      quoteId: model.id,
      ownQuoteId: null,
      historyId: null,
      searchId: null,
      createdAt: DateTime.now().toIso8601String(),
      collections: [],
    );
  }

  /// Factory method to create FavouriteModel from OwnQuoteModel
  factory FavouriteModel.fromOwnQuoteModel(OwnQuoteModel model) {
    return FavouriteModel(
      id: 0, // Will be set by database auto-increment
      quote: model.quoteText,
      quoteId: null,
      ownQuoteId: model.id,
      historyId: null,
      searchId: null,
      createdAt: DateTime.now().toIso8601String(),
      collections: [],
    );
  }

  factory FavouriteModel.fromHistoryModel(HistoryModel model) {
    return FavouriteModel(
      id: 0, // Will be set by database auto-increment
      quote: model.quoteText,
      historyId: model.id,
      ownQuoteId: null,
      quoteId: null,
      searchId: null,
      createdAt: DateTime.now().toIso8601String(),
      collections: [],
    );
  }

  factory FavouriteModel.fromSearchModel(SearchModel model) {
    return FavouriteModel(
      id: 0, // Will be set by database auto-increment
      quote: model.quoteText,
      searchId: model.id,
      ownQuoteId: null,
      quoteId: null,
      historyId: null,
      createdAt: DateTime.now().toIso8601String(),
      collections: [],
    );
  }

  factory FavouriteModel.fromEntity(FavouriteEntity entity) {
    return FavouriteModel(
      id: entity.id,
      quote: entity.quote,
      quoteId: entity.quoteId,
      ownQuoteId: entity.ownQuoteId,
      historyId: entity.historyId,
      searchId: entity.searchId,
      createdAt: entity.createdAt,
      collections:
          entity.collections.map((e) => CollectionModel.fromEntity(e)).toList(),
    );
  }

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    List<CollectionModel> collections = [];
    if (json['collections'] != null && json['collections'] is List) {
      final collectionsList = json['collections'] as List<dynamic>;
      if (collectionsList.isNotEmpty) {
        collections =
            collectionsList
                .map((e) => CollectionModel.fromJson(e as Map<String, dynamic>))
                .toList();
      }
    }
    return FavouriteModel(
      id: json['id'] as int,
      quote: json['quote'] as String,
      quoteId: json['quoteId'] as int,
      ownQuoteId: json['ownQuoteId'] as int,
      historyId: json['historyId'] as int,
      searchId: json['searchId'] as int,
      createdAt: json['createdAt'] as String,
      collections: collections,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quote': quote,
      'quoteId': quoteId,
      'ownQuoteId': ownQuoteId,
      'historyId': historyId,
      'searchId': searchId,
      'createdAt': createdAt,
      'collections': collections.map((e) => e.toJson()).toList(),
    };
  }
}
