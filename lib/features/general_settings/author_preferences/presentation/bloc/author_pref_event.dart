import 'package:sureline/features/general_settings/author_preferences/domain/entity/author_pref_entity.dart';

abstract class AuthorPrefEvent {
  const AuthorPrefEvent();
}

class GetAuthorPrefOptions extends AuthorPrefEvent {
  const GetAuthorPrefOptions();
}

class OnAuthorPrefPressed extends AuthorPrefEvent {
  final List<AuthorPrefEntity> authorPrefs;
  OnAuthorPrefPressed(this.authorPrefs);
}
