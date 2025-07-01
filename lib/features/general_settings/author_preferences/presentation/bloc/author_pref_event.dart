import 'package:sureline/features/general_settings/author_preferences/domain/entity/author_pref_entity.dart';

abstract class AuthorPrefEvent {
  const AuthorPrefEvent();
}

class GetAuthorPrefOptions extends AuthorPrefEvent {
  const GetAuthorPrefOptions();
}

class OnAuthorPrefPressed extends AuthorPrefEvent {
  final AuthorPrefEntity authorPref;
  OnAuthorPrefPressed(this.authorPref);
}
