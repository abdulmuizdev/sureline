import 'package:sureline/features/preferenecs/collections/data/model/collection_model.dart';
import 'package:sureline/features/preferenecs/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/preferenecs/history/domain/entity/history_entity.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/entity/own_quote_entity.dart';
import 'package:sureline/features/preferenecs/search/domain/entity/search_entity.dart';

class CollectionEntity {
  final int id;
  final String name;
  final List<FavouriteEntity> favouriteQuotes;
  final List<OwnQuoteEntity> ownQuotes;
  final List<HistoryEntity> historyQuotes;
  final List<SearchEntity> searchQuotes;

  CollectionEntity({
    required this.id,
    required this.name,
    required this.favouriteQuotes,
    required this.ownQuotes,
    required this.historyQuotes,
    required this.searchQuotes,
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
      historyQuotes:
          model.historyQuotes.map((e) => HistoryEntity.fromModel(e)).toList(),
      searchQuotes:
          model.searchQuotes.map((e) => SearchEntity.fromModel(e)).toList(),
    );
  }
}
