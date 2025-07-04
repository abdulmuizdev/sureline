import 'package:sureline/features/preferenecs/collections/data/model/collection_model.dart';
import 'package:sureline/features/preferenecs/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/preferenecs/history/domain/entity/history_entity.dart';

class HistoryModel extends HistoryEntity {
  final List<CollectionModel> collections;
  HistoryModel({
    required super.id,
    required super.quoteText,
    required super.isFavourite,
    required this.collections,
  }) : super(collections: collections);

  factory HistoryModel.fromEntity(HistoryEntity entity) {
    return HistoryModel(
      id: entity.id,
      quoteText: entity.quoteText,
      isFavourite: entity.isFavourite,
      collections:
          entity.collections.map((e) => CollectionModel.fromEntity(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quoteText': quoteText,
      'isFavourite': isFavourite,
      'collections': collections.map((e) => e.toJson()).toList(),
    };
  }
}
