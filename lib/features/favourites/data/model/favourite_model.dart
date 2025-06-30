import 'package:drift/drift.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/features/collections/data/model/collection_model.dart';
import 'package:sureline/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/recommendation_algorithm/data/model/quote_model.dart';

class FavouriteModel extends FavouriteEntity {
  final List<CollectionModel> collections;
  FavouriteModel({
    required super.id,
    required super.quote,
    required super.createdAt,
    required this.collections,
  }) : super(collections: collections);

  /// Convert FavouriteModel to FavouritesCompanion for database operations
  FavouritesCompanion toFavouritesCompanion() {
    return FavouritesCompanion(
      id: id == 0 ? const Value.absent() : Value(id),
      quote: Value(quote),
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
      createdAt: DateTime.now().toIso8601String(),
      collections: [],
    );
  }

  factory FavouriteModel.fromEntity(FavouriteEntity entity) {
    return FavouriteModel(
      id: entity.id,
      quote: entity.quote,
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
      createdAt: json['createdAt'] as String,
      collections: collections,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quote': quote,
      'createdAt': createdAt,
      'collections': collections.map((e) => e.toJson()).toList(),
    };
  }
}
