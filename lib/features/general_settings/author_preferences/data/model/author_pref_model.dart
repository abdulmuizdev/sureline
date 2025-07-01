import 'package:sureline/features/general_settings/author_preferences/domain/entity/author_pref_entity.dart';

class AuthorPrefModel extends AuthorPrefEntity {
  AuthorPrefModel({
    required super.authorName,
    super.isPreferred,
    required super.isLocked,
  });
  factory AuthorPrefModel.fromEntity(AuthorPrefEntity entity) {
    return AuthorPrefModel(
      authorName: entity.authorName,
      isPreferred: entity.isPreferred,
      isLocked: entity.isLocked,
    );
  }
}
