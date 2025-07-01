import 'package:sureline/features/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/favourites/data/model/favourite_model.dart';

class FavouriteEntity {
  final int id;
  final String quote;
  final int? quoteId;
  final int? ownQuoteId;
  final int? historyId;
  final int? searchId;
  final String createdAt;
  final List<CollectionEntity> collections;

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

  factory FavouriteEntity.fromModel(FavouriteModel model) {
    return FavouriteEntity(
      id: model.id,
      quote: model.quote,
      quoteId: model.quoteId,
      ownQuoteId: model.ownQuoteId,
      searchId: model.searchId,
      createdAt: model.createdAt,
      collections:
          model.collections.map((e) => CollectionEntity.fromModel(e)).toList(),
    );
  }

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
