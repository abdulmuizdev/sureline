import 'package:sureline/features/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/favourites/data/model/favourite_model.dart';

class FavouriteEntity {
  final int id;
  final String quote;
  final String createdAt;
  final List<CollectionEntity> collections;

  FavouriteEntity({
    required this.id,
    required this.quote,
    required this.createdAt,
    required this.collections,
  });

  factory FavouriteEntity.fromModel(FavouriteModel model) {
    return FavouriteEntity(
      id: model.id,
      quote: model.quote,
      createdAt: model.createdAt,
      collections:
          model.collections.map((e) => CollectionEntity.fromModel(e)).toList(),
    );
  }

  FavouriteEntity copyWith({
    int? id,
    String? quote,
    String? createdAt,
    List<CollectionEntity>? collections,
  }) {
    return FavouriteEntity(
      id: id ?? this.id,
      quote: quote ?? this.quote,
      createdAt: createdAt ?? this.createdAt,
      collections: collections ?? this.collections,
    );
  }
}
