import 'package:sureline/features/general_settings/author_preferences/domain/entity/author_pref_entity.dart';

class AuthorPrefModel extends AuthorPrefEntity {
  AuthorPrefModel({
    required super.title,
    super.isSelected,
    required super.isLocked,
  });

  Map<String, dynamic> toJson() {
    return {'title': title, 'isSelected': isSelected, 'isLocked': isLocked};
  }

  factory AuthorPrefModel.fromJson(Map<String, dynamic> json) {
    return AuthorPrefModel(
      title: json['title'],
      isSelected: json['isSelected'],
      isLocked: json['isLocked'],
    );
  }

  factory AuthorPrefModel.fromEntity(AuthorPrefEntity entity) {
    return AuthorPrefModel(
      title: entity.title,
      isSelected: entity.isSelected,
      isLocked: entity.isLocked,
    );
  }
}
