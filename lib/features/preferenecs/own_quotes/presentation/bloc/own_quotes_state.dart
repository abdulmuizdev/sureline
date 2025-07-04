import 'package:sureline/features/preferenecs/own_quotes/domain/entity/own_quote_entity.dart';

abstract class OwnQuotesState {
  const OwnQuotesState();
}

class Initial extends OwnQuotesState {}

class GotOwnQuotes extends OwnQuotesState {
  final List<OwnQuoteEntity>? ownQuotes;
  const GotOwnQuotes(this.ownQuotes);
}

class SavedOwnQuote extends OwnQuotesState {
  final List<OwnQuoteEntity> ownQuotes;
  const SavedOwnQuote(this.ownQuotes);
}
