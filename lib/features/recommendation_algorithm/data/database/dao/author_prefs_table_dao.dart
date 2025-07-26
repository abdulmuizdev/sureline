import 'package:drift/drift.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/db/tables/author_prefs_table.dart';
import 'package:sureline/core/db/tables/quotes.dart';
import 'package:sureline/core/db/tables/favourites.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/data/model/author_pref_model.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/domain/entity/author_pref_entity.dart';
import 'package:sureline/features/preferenecs/general_settings/muted_content/data/model/muted_content_model.dart';

part 'author_prefs_table_dao.g.dart';

@DriftAccessor(tables: [AuthorPrefsTable, Quotes])
class AuthorPrefsTableDao extends DatabaseAccessor<AppDatabase> with _$AuthorPrefsTableDaoMixin {
  AuthorPrefsTableDao(super.db);

  Future<void> initializeAllAuthors() async {
    // Get all unique authors from quotes table
    final allAuthors = await select(quotes).get();
    final uniqueAuthors =
        allAuthors
            .map((row) => row.author)
            .where((author) => author != null)
            .map((author) => author!)
            .toSet();

    // Get existing author preferences to avoid duplicates
    final existingPrefs = await getAllAuthorPrefs();
    final existingAuthorNames = existingPrefs.map((pref) => pref.authorName).toSet();

    // Filter out authors that already have preferences
    final newAuthors =
        uniqueAuthors.where((author) => !existingAuthorNames.contains(author)).toList();

    // Insert new authors with isPreferred set to true by default
    for (final author in newAuthors) {
      // Determine if this author is premium by checking if any of their quotes are premium
      final isPremium = allAuthors.any((q) {
        print('q.author ${q.author}');
        print('author $author');
        print('q.isPremium ${q.isPremium}');
        return q.author == author && q.isPremium;
      });
      await into(authorPrefsTable).insert(
        AuthorPrefsTableCompanion(
          authorName: Value(author),
          isPreferred: const Value(true),
          isPremium: Value(isPremium),
        ),
      );
    }
  }

  Future<List<AuthorPrefModel>> getAllAuthorPrefs() {
    return select(authorPrefsTable).get().then(
      (results) =>
          results
              .map(
                (row) => AuthorPrefModel(
                  authorName: row.authorName,
                  isPreferred: row.isPreferred,
                  isPremium: row.isPremium,
                ),
              )
              .toList(),
    );
  }

  Future<void> updateAuthorPrefs(AuthorPrefModel authorPrefModel) {
    print('updating author prefs ${authorPrefModel.authorName} ${authorPrefModel.isPreferred}');
    return (update(authorPrefsTable)..where(
      (tbl) => tbl.authorName.equals(authorPrefModel.authorName),
    )).write(AuthorPrefsTableCompanion(isPreferred: Value(authorPrefModel.isPreferred)));
  }
}
