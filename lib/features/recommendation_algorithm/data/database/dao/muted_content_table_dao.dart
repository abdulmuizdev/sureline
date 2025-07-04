import 'package:drift/drift.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/db/tables/author_prefs_table.dart';
import 'package:sureline/core/db/tables/muted_content_table.dart';
import 'package:sureline/core/db/tables/quotes.dart';
import 'package:sureline/core/db/tables/favourites.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/data/model/author_pref_model.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/domain/entity/author_pref_entity.dart';
import 'package:sureline/features/preferenecs/general_settings/muted_content/data/model/muted_content_model.dart';

part 'muted_content_table_dao.g.dart';

@DriftAccessor(tables: [MutedContentTable])
class MutedContentTableDao extends DatabaseAccessor<AppDatabase>
    with _$MutedContentTableDaoMixin {
  MutedContentTableDao(super.db);

  Future<void> initializeAllMutedContent() async {
    // Check if muted content record already exists
    final existingMutedContent =
        await select(mutedContentTable).getSingleOrNull();

    // If no record exists, create a default one
    if (existingMutedContent == null) {
      await into(mutedContentTable).insert(
        const MutedContentTableCompanion(
          isWithAuthorMuted: Value(false),
          isWithoutAuthorMuted: Value(false),
        ),
      );
    }
  }

  Future<List<MutedContentModel>> getAllMutedContent() {
    return select(mutedContentTable).get().then(
      (results) =>
          results
              .map(
                (row) => MutedContentModel(
                  isWithAuthorMuted: row.isWithAuthorMuted,
                  isWithoutAuthorMuted: row.isWithoutAuthorMuted,
                ),
              )
              .toList(),
    );
  }

  Future<void> updateMutedContent(MutedContentModel mutedContentModel) async {
    print(
      'updating muted content ${mutedContentModel.isWithAuthorMuted} ${mutedContentModel.isWithoutAuthorMuted}',
    );
    final result = await (update(mutedContentTable)).write(
      MutedContentTableCompanion(
        isWithAuthorMuted: Value(mutedContentModel.isWithAuthorMuted),
        isWithoutAuthorMuted: Value(mutedContentModel.isWithoutAuthorMuted),
      ),
    );
    print('result is this $result');
    return;
  }
}
