import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/features/preferenecs/collections/data/model/collection_model.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/entity/own_quote_entity.dart';

class OwnQuoteModel extends OwnQuoteEntity {
  final List<CollectionModel> collections;

  OwnQuoteModel({
    required super.id,
    required super.quoteText,
    required super.createdAt,
    required this.collections,
    required super.isFavourite,
  }) : super(collections: collections);

  factory OwnQuoteModel.fromEntity(OwnQuoteEntity entity) {
    return OwnQuoteModel(
      id: entity.id,
      quoteText: entity.quoteText,
      createdAt: entity.createdAt,
      collections:
          entity.collections.map((e) => CollectionModel.fromEntity(e)).toList(),
      isFavourite: entity.isFavourite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quoteText': quoteText,
      'createdAt': createdAt,
      'collections':
          collections
              .map(
                (collection) => CollectionModel.fromEntity(collection).toJson(),
              )
              .toList(),
      'isFavourite': isFavourite,
    };
  }
}
