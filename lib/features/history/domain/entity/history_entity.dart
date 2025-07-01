import 'package:sureline/features/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/history/data/model/history_model.dart';

class HistoryEntity {
  final int id;
  final String quoteText;
  final bool isFavourite;
  final List<CollectionEntity> collections;

  HistoryEntity({
    required this.id,
    required this.quoteText,
    required this.isFavourite,
    required this.collections,
  });

  HistoryEntity copyWith({
    int? id,
    String? quoteText,
    bool? isFavourite,
    List<CollectionEntity>? collections,
  }) {
    return HistoryEntity(
      id: id ?? this.id,
      quoteText: quoteText ?? this.quoteText,
      isFavourite: isFavourite ?? this.isFavourite,
      collections: collections ?? this.collections,
    );
  }

  factory HistoryEntity.fromModel(HistoryModel model) {
    return HistoryEntity(
      id: model.id,
      quoteText: model.quoteText,
      isFavourite: model.isFavourite,
      collections: model.collections,
    );
  }
}
