import 'package:sureline/features/general_settings/author_preferences/data/model/author_pref_model.dart';

class AuthorPrefEntity {
  final String title;
  final bool isSelected;
  final bool isLocked;

  const AuthorPrefEntity({
    required this.title,
    this.isSelected = false,
    required this.isLocked,
  });

  AuthorPrefEntity copyWith({String? title, bool? isSelected, bool? isLocked}) {
    return AuthorPrefEntity(
      title: title ?? this.title,
      isSelected: isSelected ?? this.isSelected,
      isLocked: isLocked ?? this.isLocked,
    );
  }

  factory AuthorPrefEntity.fromModel(AuthorPrefModel model) {
    return AuthorPrefEntity(
      title: model.title,
      isSelected: model.isSelected,
      isLocked: model.isLocked,
    );
  }
}
