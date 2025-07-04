import 'package:sureline/features/preferenecs/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/preferenecs/own_quotes/data/model/own_quote_model.dart';

class OwnQuoteEntity {
  final int id;
  final String quoteText;
  final String createdAt;
  final bool isFavourite;
  final List<CollectionEntity> collections;

  OwnQuoteEntity({
    required this.id,
    required this.quoteText,
    required this.createdAt,
    required this.collections,
    required this.isFavourite,
  });

  OwnQuoteEntity copyWith({
    List<CollectionEntity>? collections,
    String? quoteText,
    String? createdAt,
    int? id,
    bool? isFavourite,
  }) {
    return OwnQuoteEntity(
      id: id ?? this.id,
      quoteText: quoteText ?? this.quoteText,
      createdAt: createdAt ?? this.createdAt,
      collections: collections ?? this.collections,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  factory OwnQuoteEntity.fromModel(OwnQuoteModel model) {
    return OwnQuoteEntity(
      id: model.id,
      quoteText: model.quoteText,
      createdAt: model.createdAt,
      collections: model.collections,
      isFavourite: model.isFavourite,
    );
  }
}
