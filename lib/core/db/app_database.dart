import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sureline/core/db/tables/author_prefs_table.dart';
import 'package:sureline/core/db/tables/collections_table.dart';
import 'package:sureline/core/db/tables/favourites.dart';
import 'package:sureline/core/db/tables/muted_content_table.dart';
import 'package:sureline/core/db/tables/own_quotes_table.dart';
import 'package:sureline/core/db/tables/quotes.dart';
import 'package:sureline/core/db/tables/references/collections_favourites.dart';
import 'package:sureline/core/db/tables/references/collections_own_quotes_table.dart';
import 'package:sureline/core/db/tables/references/collections_history.dart';
import 'package:sureline/core/db/tables/references/collections_search.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    CollectionsTable,
    Favourites,
    CollectionsFavourites,
    Quotes,
    OwnQuotesTable,
    CollectionsOwnQuotesTable,
    CollectionsHistoryQuotes,
    CollectionsSearchQuotes,
    AuthorPrefsTable,
    MutedContentTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 17;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      await m.createAll();
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
