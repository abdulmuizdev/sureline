import 'package:drift/drift.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/db/tables/quotes.dart';
import 'package:sureline/core/db/tables/favourites.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/data/model/author_pref_model.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/domain/entity/author_pref_entity.dart';
import 'package:sureline/features/preferenecs/general_settings/muted_content/data/model/muted_content_model.dart';

part 'quotes_dao.g.dart';

@DriftAccessor(tables: [Quotes, Favourites])
class QuotesDao extends DatabaseAccessor<AppDatabase> with _$QuotesDaoMixin {
  QuotesDao(AppDatabase db) : super(db);

  Future<List<Quote>> getAllQuotes() {
    return select(quotes).get();
  }

  Future<List<Quote>> getAllQuotesWithLimit(int limit) {
    return (select(quotes)
          ..where((tbl) => tbl.isRestricted.equals(false))
          ..limit(limit))
        .get();
  }

  Future<void> updateOrder(int quoteId, int newOrder) {
    return (update(quotes)..where(
      (tbl) => tbl.id.equals(quoteId),
    )).write(QuotesCompanion(order: Value(newOrder)));
  }

  Future<List<Quote>> getAllNewQuotes() {
    return (select(quotes)
          ..where(
            (tbl) => tbl.shownAt.isNull() & tbl.isRestricted.equals(false),
          )
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.order)]))
        .get();
  }

  Future<List<Quote>> getShownQuotes() {
    return (select(quotes)
          ..where((tbl) => tbl.shownAt.isNotNull())
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.shownAt, mode: OrderingMode.desc),
          ]))
        .get();
  }

  Future<void> addQuote(QuotesCompanion quote) {
    return into(quotes).insert(quote);
  }

  Future<void> updateQuote(QuotesCompanion quote) {
    return (update(quotes)
      ..where((tbl) => tbl.id.equals(quote.id.value))).write(quote);
  }

  Future<void> markQuoteAsShown(int quoteId, DateTime shownAt) {
    return (update(quotes)..where(
      (tbl) => tbl.id.equals(quoteId),
    )).write(QuotesCompanion(shownAt: Value(shownAt)));
  }

  Future<void> markQuoteAsNotShown(int quoteId) {
    return (update(quotes)..where(
      (tbl) => tbl.id.equals(quoteId),
    )).write(QuotesCompanion(shownAt: Value(null)));
  }

  Future<void> deleteAllQuotes() {
    return delete(quotes).go();
  }

  Future<bool> isQuoteFavourite(int quoteId) {
    return (select(favourites)..where(
      (tbl) => tbl.quoteId.equals(quoteId),
    )).getSingleOrNull().then((favourite) => favourite != null);
  }

  Future<bool> isSearchFavourite(int searchId) {
    return (select(favourites)..where(
      (tbl) => tbl.searchId.equals(searchId),
    )).getSingleOrNull().then((favourite) => favourite != null);
  }

  Future<void> restrictAllQuotesWithAuthor() {
    return (update(quotes)..where(
      (tbl) => tbl.author.isNotNull(),
    )).write(QuotesCompanion(isRestricted: Value(true)));
  }

  Future<void> liftRestrictionOnAllQuotesWithAuthor() {
    return (update(quotes)..where(
      (tbl) => tbl.author.isNotNull(),
    )).write(QuotesCompanion(isRestricted: Value(false)));
  }

  Future<void> restrictAllQuotesWithoutAuthor() {
    return (update(quotes)..where(
      (tbl) => tbl.author.isNull(),
    )).write(QuotesCompanion(isRestricted: Value(true)));
  }

  Future<void> liftRestrictionOnAllQuotesWithoutAuthor() {
    return (update(quotes)..where(
      (tbl) => tbl.author.isNull(),
    )).write(QuotesCompanion(isRestricted: Value(false)));
  }
}
