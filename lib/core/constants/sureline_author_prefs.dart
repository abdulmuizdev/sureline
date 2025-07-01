import 'package:sureline/features/general_settings/author_preferences/data/model/author_pref_model.dart';

class SurelineAuthorPrefs {
  static final List<AuthorPrefModel> values = [
    AuthorPrefModel(
      authorName: 'Napoleon Hill',
      isLocked: false,
      isPreferred: true,
    ),
    AuthorPrefModel(
      authorName: 'Jim Collins',
      isLocked: false,
      isPreferred: true,
    ),
    AuthorPrefModel(authorName: 'Peter Drucker', isLocked: true),
  ];
}
