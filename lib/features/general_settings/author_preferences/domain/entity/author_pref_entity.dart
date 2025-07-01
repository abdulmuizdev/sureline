import 'package:sureline/features/general_settings/author_preferences/data/model/author_pref_model.dart';

class AuthorPrefEntity {
  final String authorName;
  final bool isPreferred;
  final bool isLocked;

  const AuthorPrefEntity({
    required this.authorName,
    this.isPreferred = false,
    required this.isLocked,
  });

  AuthorPrefEntity copyWith({
    String? authorName,
    bool? isPreferred,
    bool? isLocked,
  }) {
    return AuthorPrefEntity(
      authorName: authorName ?? this.authorName,
      isPreferred: isPreferred ?? this.isPreferred,
      isLocked: isLocked ?? this.isLocked,
    );
  }

  factory AuthorPrefEntity.fromModel(AuthorPrefModel model) {
    return AuthorPrefEntity(
      authorName: model.authorName,
      isPreferred: model.isPreferred,
      isLocked: model.isLocked,
    );
  }
}
