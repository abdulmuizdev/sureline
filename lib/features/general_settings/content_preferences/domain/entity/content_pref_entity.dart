import 'package:sureline/features/general_settings/content_preferences/data/model/content_pref_model.dart';

class ContentPrefEntity {
  final String title;
  final bool isSelected;

  const ContentPrefEntity({required this.title, this.isSelected = false});

  ContentPrefEntity copyWith({String? title, bool? isSelected}) {
    return ContentPrefEntity(
      title: title ?? this.title,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory ContentPrefEntity.fromModel(ContentPrefModel model){
    return ContentPrefEntity(title: model.title, isSelected: model.isSelected);
  }
}
