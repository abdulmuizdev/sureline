import 'package:sureline/features/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/search/data/model/search_model.dart';

class SearchEntity {
  final int id;
  final String quoteText;
  final bool isFavourite;
  final List<CollectionEntity> collections;

  SearchEntity({
    required this.id,
    required this.quoteText,
    required this.isFavourite,
    required this.collections,
  });

  SearchEntity copyWith({
    int? id,
    String? quoteText,
    bool? isFavourite,
    List<CollectionEntity>? collections,
  }) {
    return SearchEntity(
      id: id ?? this.id,
      quoteText: quoteText ?? this.quoteText,
      isFavourite: isFavourite ?? this.isFavourite,
      collections: collections ?? this.collections,
    );
  }

  factory SearchEntity.fromModel(SearchModel model) {
    return SearchEntity(
      id: model.id,
      quoteText: model.quoteText,
      isFavourite: model.isFavourite,
      collections: model.collections,
    );
  }
}
