import 'package:sureline/common/data/model/collections/collection_model.dart';
import 'package:sureline/common/domain/entities/collections/search_entity.dart';

/// Data model representing a search result with JSON serialization capabilities.
class SearchModel extends SearchEntity {
  /// Creates a new SearchModel instance.
  final List<CollectionModel> collections;

  const SearchModel({
    required super.id,
    required super.quoteText,
    required super.isFavourite,
    required this.collections,
  }) : super(collections: collections);

  /// Creates a SearchModel from a SearchEntity.
  factory SearchModel.fromEntity(SearchEntity entity) {
    return SearchModel(
      id: entity.id,
      quoteText: entity.quoteText,
      isFavourite: entity.isFavourite,
      collections: entity.collections.map((e) => CollectionModel.fromEntity(e)).toList(),
    );
  }

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      quoteText: json['quoteText']?.toString() ?? '',
      isFavourite: json['isFavourite'] == true,
      collections:
          (json['collections'] as List<dynamic>?)
              ?.map((e) => CollectionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quoteText': quoteText,
      'isFavourite': isFavourite,
      'collections': collections.map((e) => CollectionModel.fromEntity(e).toJson()).toList(),
    };
  }
}
