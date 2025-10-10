# Sureline Database Documentation

## Overview

Sureline uses **Drift** (formerly Moor) as its database solution, providing type-safe SQLite operations with code generation. This document outlines the database schema, relationships, and usage patterns.

## 🗄️ Database Schema

### Core Tables

#### Collections Table
Stores user-created collections of quotes.

```dart
class CollectionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();
}
```

**Fields:**
- `id`: Primary key, auto-incrementing integer
- `name`: Collection name (text)
- `createdAt`: Timestamp when collection was created

#### Quotes Table
Stores the main quote data.

```dart
class Quotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get quote => text()();
  TextColumn get author => text()();
  TextColumn get category => text()();
  DateTimeColumn get createdAt => dateTime()();
}
```

**Fields:**
- `id`: Primary key, auto-incrementing integer
- `quote`: The quote text content
- `author`: Quote author name
- `category`: Quote category/topic
- `createdAt`: Timestamp when quote was added

#### Favourites Table
Tracks user-favorited quotes with references to different quote types.

```dart
class Favourites extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get quote => text()();
  IntColumn get quoteId => integer().nullable()();
  IntColumn get ownQuoteId => integer().nullable()();
  IntColumn get historyId => integer().nullable()();
  IntColumn get searchId => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}
```

**Fields:**
- `id`: Primary key, auto-incrementing integer
- `quote`: The quote text (for quick access)
- `quoteId`: Reference to main quotes table (nullable)
- `ownQuoteId`: Reference to user-created quotes (nullable)
- `historyId`: Reference to history quotes (nullable)
- `searchId`: Reference to search quotes (nullable)
- `createdAt`: Timestamp when favorited

#### Own Quotes Table
Stores user-created quotes.

```dart
class OwnQuotesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get quoteText => text()();
  DateTimeColumn get createdAt => dateTime()();
}
```

**Fields:**
- `id`: Primary key, auto-incrementing integer
- `quoteText`: User-created quote content
- `createdAt`: Timestamp when created

### Junction Tables (Many-to-Many Relationships)

#### Collections-Favourites Junction
Links collections to favorited quotes.

```dart
class CollectionsFavourites extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get collectionId => integer().references(CollectionsTable, #id)();
  IntColumn get favouriteId => integer().references(Favourites, #id)();
}
```

**Fields:**
- `id`: Primary key, auto-incrementing integer
- `collectionId`: Foreign key to collections table
- `favouriteId`: Foreign key to favourites table

#### Collections-Own Quotes Junction
Links collections to user-created quotes.

```dart
class CollectionsOwnQuotesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get collectionId => integer().references(CollectionsTable, #id)();
  IntColumn get ownQuoteId => integer().references(OwnQuotesTable, #id)();
}
```

**Fields:**
- `id`: Primary key, auto-incrementing integer
- `collectionId`: Foreign key to collections table
- `ownQuoteId`: Foreign key to own quotes table

#### Collections-History Junction
Links collections to history quotes.

```dart
class CollectionsHistoryQuotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get collectionId => integer().references(CollectionsTable, #id)();
  IntColumn get quoteId => integer().references(Quotes, #id)();
}
```

**Fields:**
- `id`: Primary key, auto-incrementing integer
- `collectionId`: Foreign key to collections table
- `quoteId`: Foreign key to quotes table

#### Collections-Search Junction
Links collections to search results.

```dart
class CollectionsSearchQuotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get collectionId => integer().references(CollectionsTable, #id)();
  IntColumn get searchId => integer()(); // Reference to search results
}
```

**Fields:**
- `id`: Primary key, auto-incrementing integer
- `collectionId`: Foreign key to collections table
- `searchId`: Reference to search result ID

### Settings Tables

#### Author Preferences Table
Stores user preferences for quote authors.

```dart
class AuthorPrefsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get authorName => text()();
  BoolColumn get isMuted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}
```

**Fields:**
- `id`: Primary key, auto-incrementing integer
- `authorName`: Name of the author
- `isMuted`: Whether the author is muted by user
- `createdAt`: Timestamp when preference was set

#### Muted Content Table
Stores user-muted content categories.

```dart
class MutedContentTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get contentType => text()();
  TextColumn get contentValue => text()();
  DateTimeColumn get createdAt => dateTime()();
}
```

**Fields:**
- `id`: Primary key, auto-incrementing integer
- `contentType`: Type of muted content (author, category, etc.)
- `contentValue`: Specific value that is muted
- `createdAt`: Timestamp when content was muted

## 🔄 Database Operations

### Data Access Objects (DAOs)

#### Collections DAO
```dart
@DriftAccessor(tables: [CollectionsTable])
class CollectionsDao extends DatabaseAccessor<AppDatabase>
    with _$CollectionsDaoMixin {
  CollectionsDao(AppDatabase db) : super(db);

  Future<List<CollectionsTableData>> getAllCollections() {
    return select(collectionsTable).get();
  }

  Future<void> addCollection(CollectionsTableCompanion collection) {
    return into(collectionsTable).insert(collection);
  }

  Future<void> removeCollection(int id) {
    return (delete(collectionsTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
```

#### Favourites DAO
```dart
@DriftAccessor(tables: [Favourites])
class FavouritesDao extends DatabaseAccessor<AppDatabase>
    with _$FavouritesDaoMixin {
  FavouritesDao(AppDatabase db) : super(db);

  Future<List<FavouritesData>> getAllFavourites() {
    return select(favourites).get();
  }

  Future<void> addFavourite(FavouritesCompanion favourite) {
    return into(favourites).insert(favourite);
  }

  Future<void> removeFavourite({
    int? quoteId,
    int? ownQuoteId,
    int? historyId,
    int? searchId,
  }) {
    return (delete(favourites)
          ..where((tbl) =>
              (quoteId != null ? tbl.quoteId.equals(quoteId) : null) |
              (ownQuoteId != null ? tbl.ownQuoteId.equals(ownQuoteId) : null) |
              (historyId != null ? tbl.historyId.equals(historyId) : null) |
              (searchId != null ? tbl.searchId.equals(searchId) : null)))
        .go();
  }
}
```

### Junction Table DAOs

#### Collections-Favourites Junction DAO
```dart
@DriftAccessor(tables: [CollectionsFavourites])
class CollectionsFavouritesDao extends DatabaseAccessor<AppDatabase>
    with _$CollectionsFavouritesDaoMixin {
  CollectionsFavouritesDao(AppDatabase db) : super(db);

  Future<List<FavouritesData>> getFavouritesOfCollection(int collectionId) {
    return (select(favourites)
          ..where((tbl) => tbl.id.isInQuery(
                select(collectionsFavourites)
                  .where((j) => j.collectionId.equals(collectionId))
                  .map((j) => j.favouriteId),
              )))
        .get();
  }

  Future<List<CollectionsTableData>> getCollectionsOfFavourite(int favouriteId) {
    return (select(collectionsTable)
          ..where((tbl) => tbl.id.isInQuery(
                select(collectionsFavourites)
                  .where((j) => j.favouriteId.equals(favouriteId))
                  .map((j) => j.collectionId),
              )))
        .get();
  }
}
```

## 📊 Query Examples

### Complex Queries

#### Get Collections with Quote Counts
```dart
Future<List<CollectionWithCount>> getCollectionsWithCounts() {
  return customSelect(
    'SELECT c.id, c.name, c.createdAt, COUNT(cf.favouriteId) as quoteCount '
    'FROM collections c '
    'LEFT JOIN collections_favourites cf ON c.id = cf.collectionId '
    'GROUP BY c.id, c.name, c.createdAt '
    'ORDER BY c.createdAt DESC',
    readsFrom: {collectionsTable, collectionsFavourites},
  ).map((row) => CollectionWithCount(
    id: row.read<int>('id'),
    name: row.read<String>('name'),
    createdAt: row.read<DateTime>('createdAt'),
    quoteCount: row.read<int>('quoteCount'),
  )).get();
}
```

#### Get Favourites with Collection Information
```dart
Future<List<FavouriteWithCollections>> getFavouritesWithCollections() {
  return customSelect(
    'SELECT f.*, GROUP_CONCAT(c.name) as collectionNames '
    'FROM favourites f '
    'LEFT JOIN collections_favourites cf ON f.id = cf.favouriteId '
    'LEFT JOIN collections c ON cf.collectionId = c.id '
    'GROUP BY f.id '
    'ORDER BY f.createdAt DESC',
    readsFrom: {favourites, collectionsFavourites, collectionsTable},
  ).map((row) => FavouriteWithCollections(
    favourite: FavouritesData.fromData(row.data),
    collectionNames: row.read<String>('collectionNames')?.split(',') ?? [],
  )).get();
}
```

## 🔧 Database Configuration

### App Database Setup
```dart
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
```

### Connection Setup
```dart
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
```

## 📈 Performance Optimization

### Indexes
```dart
// Add indexes for frequently queried columns
class CollectionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Custom indexes for junction tables
class CollectionsFavourites extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get collectionId => integer().references(CollectionsTable, #id)();
  IntColumn get favouriteId => integer().references(Favourites, #id)();

  @override
  Set<Column> get primaryKey => {id};

  // Add indexes for foreign keys
  @override
  List<Set<Column>> get uniqueKeys => [
    {collectionId, favouriteId},
  ];
}
```

### Query Optimization
1. **Use specific column selection** instead of `SELECT *`
2. **Add appropriate indexes** for frequently queried columns
3. **Use transactions** for multiple related operations
4. **Implement pagination** for large datasets

```dart
// Optimized query with specific columns
Future<List<CollectionEntity>> getCollectionsOptimized() {
  return (select(collectionsTable)
        ..columns([collectionsTable.id, collectionsTable.name, collectionsTable.createdAt])
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .get();
}
```

## 🔒 Data Integrity

### Foreign Key Constraints
```dart
class CollectionsFavourites extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get collectionId => integer().references(CollectionsTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get favouriteId => integer().references(Favourites, #id, onDelete: KeyAction.cascade)();
}
```

### Unique Constraints
```dart
class CollectionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  // Ensure unique collection names per user
  @override
  List<Set<Column>> get uniqueKeys => [
    {name},
  ];
}
```

## 🧪 Testing Database Operations

### Unit Testing DAOs
```dart
void main() {
  group('CollectionsDao', () {
    late AppDatabase database;
    late CollectionsDao dao;

    setUp(() {
      database = AppDatabase.memory();
      dao = CollectionsDao(database);
    });

    tearDown(() async {
      await database.close();
    });

    test('should add and retrieve collection', () async {
      // Arrange
      final collection = CollectionsTableCompanion.insert(
        name: 'Test Collection',
        createdAt: DateTime.now(),
      );

      // Act
      await dao.addCollection(collection);
      final collections = await dao.getAllCollections();

      // Assert
      expect(collections.length, 1);
      expect(collections.first.name, 'Test Collection');
    });
  });
}
```

### Integration Testing
```dart
testWidgets('should save and display collections', (WidgetTester tester) async {
  // Arrange
  final database = AppDatabase.memory();
  final dao = CollectionsDao(database);

  await dao.addCollection(CollectionsTableCompanion.insert(
    name: 'Test Collection',
    createdAt: DateTime.now(),
  ));

  // Act
  await tester.pumpWidget(
    MaterialApp(
      home: CollectionsPage(database: database),
    ),
  );
  await tester.pumpAndSettle();

  // Assert
  expect(find.text('Test Collection'), findsOneWidget);
});
```

## 📊 Database Statistics

### Schema Information
- **Total Tables**: 10
- **Junction Tables**: 4
- **Core Tables**: 4
- **Settings Tables**: 2
- **Current Schema Version**: 17

### Table Relationships
```
CollectionsTable (1) ←→ (N) CollectionsFavourites (N) ←→ (1) Favourites
CollectionsTable (1) ←→ (N) CollectionsOwnQuotesTable (N) ←→ (1) OwnQuotesTable
CollectionsTable (1) ←→ (N) CollectionsHistoryQuotes (N) ←→ (1) Quotes
CollectionsTable (1) ←→ (N) CollectionsSearchQuotes (N) ←→ (1) SearchResults
```

## 🔄 Migration Strategy

### Version Management
```dart
@override
MigrationStrategy get migration => MigrationStrategy(
  onCreate: (Migrator m) async {
    await m.createAll();
  },
  onUpgrade: (Migrator m, int from, int to) async {
    // Handle schema migrations
    if (from < 17) {
      // Migration logic for version 17
      await m.createAll();
    }
  },
);
```

### Migration Best Practices
1. **Always backup data** before migrations
2. **Test migrations** on sample data
3. **Use transactions** for complex migrations
4. **Provide rollback strategies** for critical migrations
5. **Document migration changes** thoroughly

---

This database architecture provides a robust foundation for Sureline's data management needs while maintaining performance and data integrity.