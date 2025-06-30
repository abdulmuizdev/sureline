import 'package:sureline/features/general_settings/author_preferences/domain/entity/author_pref_entity.dart';

abstract class AuthorPrefState {
  const AuthorPrefState();
}

class Initial extends AuthorPrefState {
  const Initial();
}

class GettingAuthorPrefOptions extends AuthorPrefState {
  const GettingAuthorPrefOptions();
}

class GotAuthorPrefOptions extends AuthorPrefState {
  final List<AuthorPrefEntity> result;
  const GotAuthorPrefOptions(this.result);
}

class AuthorPrefError extends AuthorPrefState {
  final String message;
  const AuthorPrefError(this.message);
}
