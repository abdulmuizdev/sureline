import 'package:sureline/features/collections/data/model/collection_model.dart';
import 'package:sureline/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/own_quotes/domain/entity/own_quote_entity.dart';

class CollectionEntity {
  final int id;
  final String name;
  final List<FavouriteEntity> favouriteQuotes;
  final List<OwnQuoteEntity> ownQuotes;

  CollectionEntity({
    required this.id,
    required this.name,
    required this.favouriteQuotes,
    required this.ownQuotes,
  });

  factory CollectionEntity.fromModel(CollectionModel model) {
    return CollectionEntity(
      id: model.id,
      name: model.name,
      favouriteQuotes:
          model.favouriteQuotes
              .map((e) => FavouriteEntity.fromModel(e))
              .toList(),
      ownQuotes:
          model.ownQuotes.map((e) => OwnQuoteEntity.fromModel(e)).toList(),
    );
  }
}
