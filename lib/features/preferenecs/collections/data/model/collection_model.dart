import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/features/preferenecs/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/preferenecs/favourites/data/model/favourite_model.dart';
import 'package:sureline/features/preferenecs/history/data/model/history_model.dart';
import 'package:sureline/features/home/data/model/quote_model.dart';
import 'package:sureline/features/preferenecs/own_quotes/data/model/own_quote_model.dart';
import 'package:sureline/features/preferenecs/search/data/model/search_model.dart';

class CollectionModel extends CollectionEntity {
  final List<FavouriteModel> favouriteQuotes;
  final List<OwnQuoteModel> ownQuotes;
  final List<HistoryModel> historyQuotes;
  final List<SearchModel> searchQuotes;
  CollectionModel({
    required super.id,
    required super.name,
    required this.favouriteQuotes,
    required this.ownQuotes,
    required this.historyQuotes,
    required this.searchQuotes,
  }) : super(
         favouriteQuotes: favouriteQuotes,
         ownQuotes: ownQuotes,
         historyQuotes: historyQuotes,
         searchQuotes: searchQuotes,
       );

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    List<FavouriteModel> quotes = [];
    if (json['quotes'] != null && json['quotes'] is List) {
      final quotesList = json['quotes'] as List<dynamic>;
      if (quotesList.isNotEmpty) {
        quotes =
            quotesList
                .map(
                  (quote) =>
                      FavouriteModel.fromJson(quote as Map<String, dynamic>),
                )
                .toList();
      }
    }

    return CollectionModel(
      id: json['id'] as int,
      name: json['name'] as String,
      favouriteQuotes: quotes,
      ownQuotes: [],
      historyQuotes: [],
      searchQuotes: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'favouriteQuotes':
          favouriteQuotes
              .map((quote) => FavouriteModel.fromEntity(quote).toJson())
              .toList(),
      'ownQuotes':
          ownQuotes
              .map((quote) => OwnQuoteModel.fromEntity(quote).toJson())
              .toList(),
      'historyQuotes':
          historyQuotes
              .map((quote) => HistoryModel.fromEntity(quote).toJson())
              .toList(),
      'searchQuotes':
          searchQuotes
              .map((quote) => SearchModel.fromEntity(quote).toJson())
              .toList(),
    };
  }

  factory CollectionModel.fromEntity(CollectionEntity entity) {
    return CollectionModel(
      id: entity.id,
      name: entity.name,
      favouriteQuotes:
          entity.favouriteQuotes
              .map((e) => FavouriteModel.fromEntity(e))
              .toList(),
      ownQuotes:
          entity.ownQuotes.map((e) => OwnQuoteModel.fromEntity(e)).toList(),
      historyQuotes:
          entity.historyQuotes.map((e) => HistoryModel.fromEntity(e)).toList(),
      searchQuotes:
          entity.searchQuotes.map((e) => SearchModel.fromEntity(e)).toList(),
    );
  }

  factory CollectionModel.fromCollection(CollectionsTableData dbCollection) {
    return CollectionModel(
      id: dbCollection.id,
      name: dbCollection.name,
      favouriteQuotes: [],
      ownQuotes: [],
      historyQuotes: [],
      searchQuotes: [],
    );
  }
}
