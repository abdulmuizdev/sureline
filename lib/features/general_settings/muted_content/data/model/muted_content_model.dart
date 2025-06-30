import 'package:sureline/features/general_settings/muted_content/domain/entity/muted_content_entity.dart';

class MutedContentModel extends MutedContentEntity {
  MutedContentModel({required super.title, required super.isSelected});

  factory MutedContentModel.fromJson(Map<String, dynamic> json) {
    return MutedContentModel(
      title: json['title'],
      isSelected: json['isSelected'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'isSelected': isSelected};
  }

  MutedContentModel copyWith({String? title, bool? isSelected}) {
    return MutedContentModel(
      title: title ?? this.title,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory MutedContentModel.fromEntity(MutedContentEntity entity) {
    return MutedContentModel(
      title: entity.title,
      isSelected: entity.isSelected,
    );
  }
}
