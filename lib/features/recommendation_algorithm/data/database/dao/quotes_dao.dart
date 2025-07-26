import 'package:drift/drift.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/db/tables/quotes.dart';
import 'package:sureline/core/db/tables/favourites.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/data/model/author_pref_model.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/domain/entity/author_pref_entity.dart';
import 'package:sureline/features/preferenecs/general_settings/muted_content/data/model/muted_content_model.dart';

part 'quotes_dao.g.dart';

/// Data Access Object for quote database operations in the recommendation algorithm.
///
/// This DAO provides comprehensive database access for quote management,
/// including retrieval, filtering, ordering, and status tracking. It serves
/// as the foundation for the recommendation algorithm by providing efficient
/// data access patterns for quote discovery and user preference management.
///
/// Key Features:
/// - Quote retrieval with various filtering options
/// - Order management for recommendation algorithm
/// - Favorite status tracking and management
/// - Quote visibility and restriction controls
/// - Author-based filtering and preferences
/// - Performance optimization with pagination
///
/// Recommendation Algorithm Integration:
/// - Tracks quote display history for algorithm input
/// - Manages quote ordering for personalized recommendations
/// - Provides filtered quotes based on user preferences
/// - Supports author-based content filtering
/// - Enables restriction management for content control
///
/// Database Operations:
/// - Efficient quote retrieval with Drift ORM
/// - Complex filtering and ordering queries
/// - Batch operations for performance
/// - Transaction support for data consistency
/// - Relationship management with favorites table
///
/// Usage:
/// ```dart
/// final quotesDao = QuotesDao(database);
/// final newQuotes = await quotesDao.getAllNewQuotes();
/// ```
@DriftAccessor(tables: [Quotes, Favourites])
class QuotesDao extends DatabaseAccessor<AppDatabase> with _$QuotesDaoMixin {
  /// Creates a new QuotesDao instance with database access.
  QuotesDao(AppDatabase db) : super(db);

  /// Retrieves all quotes from the database.
  ///
  /// Returns a complete list of all quotes stored in the database,
  /// regardless of their status or visibility. This method is used
  /// for comprehensive quote management and bulk operations.
  ///
  /// Returns:
  /// - [Future<List<Quote>>] Complete list of all quotes
  Future<List<Quote>> getAllQuotes({required bool isPremium}) {
    final query = select(quotes);
    if (isPremium == true) {
      // Return all quotes (premium and non-premium)
    } else {
      // Only non-premium quotes
      query.where((tbl) => tbl.isPremium.equals(false));
    }
    return query.get();
  }

  Future<List<Quote>> getAllQuotesWithQuery(String queryStr, {required bool isPremium}) {
    final query = select(quotes)..where((tbl) => tbl.quoteText.like('%$queryStr%'));
    if (isPremium == true) {
      // Return all quotes (premium and non-premium)
    } else {
      query.where((tbl) => tbl.isPremium.equals(false));
    }
    return query.get();
  }

  /// Retrieves quotes with a specified limit for performance optimization.
  ///
  /// This method retrieves quotes with a limit and excludes restricted
  /// content, making it suitable for recommendation algorithms that
  /// need to process quotes in batches.
  ///
  /// Parameters:
  /// - [limit] Maximum number of quotes to retrieve
  ///
  /// Returns:
  /// - [Future<List<Quote>>] Limited list of non-restricted quotes
  Future<List<Quote>> getAllQuotesWithLimit(int limit, {required bool isPremium}) {
    final query =
        select(quotes)
          ..where((tbl) => tbl.isRestricted.equals(false))
          ..limit(limit);
    if (isPremium == true) {
      // Return all quotes (premium and non-premium)
    } else {
      query.where((tbl) => tbl.isPremium.equals(false));
    }
    return query.get();
  }

  /// Updates the order of a specific quote for recommendation algorithm.
  ///
  /// This method allows the recommendation algorithm to adjust quote
  /// ordering based on user preferences and engagement patterns.
  ///
  /// Parameters:
  /// - [quoteId] ID of the quote to update
  /// - [newOrder] New order value for the quote
  Future<void> updateOrder(int quoteId, int newOrder) {
    return (update(quotes)
      ..where((tbl) => tbl.id.equals(quoteId))).write(QuotesCompanion(order: Value(newOrder)));
  }

  /// Retrieves quotes that haven't been shown to the user yet.
  ///
  /// This method is crucial for the recommendation algorithm as it
  /// provides fresh content that hasn't been displayed to the user.
  /// Quotes are ordered by their recommendation order for optimal
  /// user experience.
  ///
  /// Returns:
  /// - [Future<List<Quote>>] List of new quotes ordered by recommendation priority
  Future<List<Quote>> getAllNewQuotes({required bool isPremium}) {
    final query =
        select(quotes)
          ..where((tbl) => tbl.shownAt.isNull() & tbl.isRestricted.equals(false))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.order)]);
    if (isPremium == true) {
      // Return all quotes (premium and non-premium)
    } else {
      query.where((tbl) => tbl.isPremium.equals(false));
    }
    return query.get();
  }

  /// Retrieves quotes that have been shown to the user.
  ///
  /// This method provides access to the user's quote history, which
  /// is useful for analytics, user engagement tracking, and
  /// recommendation algorithm refinement.
  ///
  /// Returns:
  /// - [Future<List<Quote>>] List of shown quotes ordered by display time
  Future<List<Quote>> getShownQuotes({required bool isPremium}) {
    final query =
        select(quotes)
          ..where((tbl) => tbl.shownAt.isNotNull())
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.shownAt, mode: OrderingMode.desc)]);
    if (isPremium == true) {
      // Return all quotes (premium and non-premium)
    } else {
      query.where((tbl) => tbl.isPremium.equals(false));
    }
    return query.get();
  }

  /// Adds a new quote to the database.
  ///
  /// This method allows for dynamic quote addition, supporting
  /// content updates and new quote integration into the system.
  ///
  /// Parameters:
  /// - [quote] Quote companion object with all required data
  Future<void> addQuote(QuotesCompanion quote) {
    return into(quotes).insert(quote);
  }

  /// Updates an existing quote in the database.
  ///
  /// This method allows for quote content updates, metadata changes,
  /// and status modifications while maintaining data integrity.
  ///
  /// Parameters:
  /// - [quote] Quote companion object with updated data
  Future<void> updateQuote(QuotesCompanion quote) {
    return (update(quotes)..where((tbl) => tbl.id.equals(quote.id.value))).write(quote);
  }

  /// Marks a quote as shown with timestamp for recommendation tracking.
  ///
  /// This method is essential for the recommendation algorithm as it
  /// tracks user engagement and prevents duplicate quote displays.
  /// The timestamp is used for analytics and algorithm optimization.
  ///
  /// Parameters:
  /// - [quoteId] ID of the quote to mark as shown
  /// - [shownAt] Timestamp when the quote was displayed
  Future<void> markQuoteAsShown(int quoteId, DateTime shownAt) {
    return (update(quotes)
      ..where((tbl) => tbl.id.equals(quoteId))).write(QuotesCompanion(shownAt: Value(shownAt)));
  }

  /// Resets a quote's shown status for potential re-display.
  ///
  /// This method allows quotes to be shown again, useful for
  /// content rotation and ensuring users don't miss important quotes.
  ///
  /// Parameters:
  /// - [quoteId] ID of the quote to reset
  Future<void> markQuoteAsNotShown(int quoteId) {
    return (update(quotes)
      ..where((tbl) => tbl.id.equals(quoteId))).write(QuotesCompanion(shownAt: Value(null)));
  }

  /// Deletes all quotes from the database.
  ///
  /// This method provides a clean slate for quote management,
  /// useful for content updates and system resets.
  Future<void> deleteAllQuotes() {
    return delete(quotes).go();
  }

  /// Checks if a quote is marked as favorite by the user.
  ///
  /// This method supports user preference tracking and personalized
  /// content recommendations based on favorite status.
  ///
  /// Parameters:
  /// - [quoteId] ID of the quote to check
  ///
  /// Returns:
  /// - [Future<bool>] True if quote is favorited, false otherwise
  Future<bool> isQuoteFavourite(int quoteId) {
    return (select(favourites)..where(
      (tbl) => tbl.quoteId.equals(quoteId),
    )).getSingleOrNull().then((favourite) => favourite != null);
  }

  /// Checks if a search result is marked as favorite by the user.
  ///
  /// This method supports search functionality by tracking favorite
  /// status of search results for consistent user experience.
  ///
  /// Parameters:
  /// - [searchId] ID of the search result to check
  ///
  /// Returns:
  /// - [Future<bool>] True if search result is favorited, false otherwise
  Future<bool> isSearchFavourite(int searchId) {
    return (select(favourites)..where(
      (tbl) => tbl.searchId.equals(searchId),
    )).getSingleOrNull().then((favourite) => favourite != null);
  }

  /// Restricts all quotes that have an author specified.
  ///
  /// This method supports content filtering based on author preferences,
  /// allowing users to control which authors' content they see.
  Future<void> restrictAllQuotesWithAuthor() {
    return (update(quotes)
      ..where((tbl) => tbl.author.isNotNull())).write(QuotesCompanion(isRestricted: Value(true)));
  }

  /// Lifts restrictions on all quotes that have an author specified.
  ///
  /// This method allows users to re-enable content from authors
  /// they previously restricted, providing flexible content control.
  Future<void> liftRestrictionOnAllQuotesWithAuthor() {
    return (update(quotes)
      ..where((tbl) => tbl.author.isNotNull())).write(QuotesCompanion(isRestricted: Value(false)));
  }

  /// Restricts all quotes that don't have an author specified.
  ///
  /// This method supports filtering of anonymous or unattributed quotes,
  /// allowing users to focus on credited content.
  Future<void> restrictAllQuotesWithoutAuthor() {
    return (update(quotes)
      ..where((tbl) => tbl.author.isNull())).write(QuotesCompanion(isRestricted: Value(true)));
  }

  /// Lifts restrictions on all quotes that don't have an author specified.
  ///
  /// This method allows users to re-enable anonymous quotes,
  /// providing flexibility in content preferences.
  Future<void> liftRestrictionOnAllQuotesWithoutAuthor() {
    return (update(quotes)
      ..where((tbl) => tbl.author.isNull())).write(QuotesCompanion(isRestricted: Value(false)));
  }
}
