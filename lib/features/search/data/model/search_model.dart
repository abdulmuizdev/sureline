import 'package:sureline/features/search/domain/entity/search_entity.dart';

class SearchModel extends SearchEntity {
  SearchModel({
    required super.id,
    required super.quoteText,
    required super.isFavourite,
    required super.collections,
  });

  factory SearchModel.fromEntity(SearchEntity entity) {
    return SearchModel(
      id: entity.id,
      quoteText: entity.quoteText,
      isFavourite: entity.isFavourite,
      collections: entity.collections,
    );
  }

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'],
      quoteText: json['quoteText'],
      isFavourite: json['isFavourite'],
      collections: json['collections'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quoteText': quoteText,
      'isFavourite': isFavourite,
      'collections': collections,
    };
  }
}
