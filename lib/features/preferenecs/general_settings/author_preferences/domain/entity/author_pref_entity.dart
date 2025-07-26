import 'package:sureline/features/preferenecs/general_settings/author_preferences/data/model/author_pref_model.dart';

class AuthorPrefEntity {
  final String authorName;
  final bool isPreferred;

  final bool isPremium;

  const AuthorPrefEntity({
    required this.authorName,
    this.isPreferred = false,

    this.isPremium = false,
  });

  AuthorPrefEntity copyWith({String? authorName, bool? isPreferred, bool? isPremium}) {
    return AuthorPrefEntity(
      authorName: authorName ?? this.authorName,
      isPreferred: isPreferred ?? this.isPreferred,

      isPremium: isPremium ?? this.isPremium,
    );
  }

  factory AuthorPrefEntity.fromModel(AuthorPrefModel model) {
    return AuthorPrefEntity(
      authorName: model.authorName,
      isPreferred: model.isPreferred,
      isPremium: model.isPremium,
    );
  }
}
