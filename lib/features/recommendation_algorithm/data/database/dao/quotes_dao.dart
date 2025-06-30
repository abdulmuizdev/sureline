import 'package:drift/drift.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/db/tables/quotes.dart';

part 'quotes_dao.g.dart';

@DriftAccessor(tables: [Quotes])
class QuotesDao extends DatabaseAccessor<AppDatabase> with _$QuotesDaoMixin {
  QuotesDao(AppDatabase db) : super(db);

  Future<List<Quote>> getAllQuotes() {
    return select(quotes).get();
  }

  Future<List<Quote>> getAllNewQuotes() {
    return (select(quotes)
      ..where((tbl) => tbl.shownAt.isNull())
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt)]))
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

  Future<void> deleteAllQuotes() {
    return delete(quotes).go();
  }
}
