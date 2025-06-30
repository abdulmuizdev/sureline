import 'package:sureline/features/general_settings/author_preferences/data/model/author_pref_model.dart';

class SurelineAuthorPrefs {
  static final List<AuthorPrefModel> values = [
    AuthorPrefModel(title: 'Napoleon Hill', isLocked: false, isSelected: true),
    AuthorPrefModel(title: 'Jim Collins', isLocked: false, isSelected: true),
    AuthorPrefModel(title: 'Peter Drucker', isLocked: true),
  ];
}
