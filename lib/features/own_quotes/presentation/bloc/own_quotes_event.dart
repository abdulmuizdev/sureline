import 'package:sureline/features/own_quotes/domain/entity/own_quote_entity.dart';

abstract class OwnQuotesEvent {
  const OwnQuotesEvent();
}

class GetOwnQuotes extends OwnQuotesEvent {}

class OnDeletePressed extends OwnQuotesEvent {
  final OwnQuoteEntity entity;
  const OnDeletePressed(this.entity);
}

class SaveOwnQuote extends OwnQuotesEvent {
  final OwnQuoteEntity entity;
  const SaveOwnQuote(this.entity);
}
