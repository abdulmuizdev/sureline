import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/features/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/favourites/data/model/favourite_model.dart';
import 'package:sureline/features/home/data/model/quote_model.dart';
import 'package:sureline/features/own_quotes/data/model/own_quote_model.dart';

class CollectionModel extends CollectionEntity {
  final List<FavouriteModel> favouriteQuotes;
  final List<OwnQuoteModel> ownQuotes;
  CollectionModel({
    required super.id,
    required super.name,
    required this.favouriteQuotes,
    required this.ownQuotes,
  }) : super(favouriteQuotes: favouriteQuotes, ownQuotes: ownQuotes);

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
    );
  }

  factory CollectionModel.fromCollection(CollectionsTableData dbCollection) {
    return CollectionModel(
      id: dbCollection.id,
      name: dbCollection.name,
      favouriteQuotes: [],
      ownQuotes: [],
    );
  }
}
