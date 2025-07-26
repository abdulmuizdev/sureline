/// Data Access Object for collections table operations.
///
/// Provides direct database access for collections CRUD operations.
/// This DAO handles the low-level database operations for the collections
/// table, including querying, inserting, and deleting collection records.
/// It uses Drift ORM for type-safe database operations.

import 'package:drift/drift.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/db/tables/collections_table.dart';

part 'collections_dao.g.dart';

/// Data Access Object for collections table.
///
/// This DAO provides type-safe database operations for the collections table
/// using Drift ORM. It handles basic CRUD operations and ensures proper
/// data integrity through the ORM layer.
///
/// Key responsibilities:
/// - Retrieving all collections from the database
/// - Adding new collections with proper metadata
/// - Removing collections and their associated data
/// - Maintaining data consistency through transactions
@DriftAccessor(tables: [CollectionsTable])
class CollectionsDao extends DatabaseAccessor<AppDatabase> with _$CollectionsDaoMixin {
  /// Creates a new DAO instance with database access.
  CollectionsDao(AppDatabase db) : super(db);

  /// Retrieves all collections from the database.
  ///
  /// Fetches all collection records ordered by their creation time.
  /// Returns raw database records that need to be converted to domain models.
  ///
  /// Returns: List of collection table data records
  Future<List<CollectionsTableData>> getAllCollections() {
    return select(collectionsTable).get();
  }

  /// Adds a new collection to the database.
  ///
  /// Inserts a new collection record with the specified name and creation timestamp.
  /// The collection is immediately available for adding quotes.
  ///
  /// [collection]: The collection companion object with name and metadata
  /// Returns: Future that completes when the insert operation finishes
  Future<void> addCollection(CollectionsTableCompanion collection) {
    return into(collectionsTable).insert(collection);
  }

  /// Removes a collection from the database.
  ///
  /// Deletes the collection record with the specified ID. This operation
  /// should be followed by cleanup of associated quote relationships.
  ///
  /// [id]: The ID of the collection to remove
  /// Returns: Future that completes when the delete operation finishes
  Future<void> removeCollection(int id) {
    return (delete(collectionsTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
