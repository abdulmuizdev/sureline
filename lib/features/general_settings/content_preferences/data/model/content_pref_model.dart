import 'package:sureline/features/general_settings/content_preferences/domain/entity/content_pref_entity.dart';

class ContentPrefModel extends ContentPrefEntity {
  ContentPrefModel({required super.title, super.isSelected});

  Map<String, dynamic> toJson() {
    return {'title': title, 'isSelected': isSelected};
  }

  factory ContentPrefModel.fromJson(Map<String, dynamic> json) {
    return ContentPrefModel(
      title: json['title'],
      isSelected: json['isSelected'],
    );
  }

  factory ContentPrefModel.fromEntity(ContentPrefEntity entity) {
    return ContentPrefModel(title: entity.title, isSelected: entity.isSelected);
  }
}
