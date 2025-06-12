import 'package:sureline/features/home/domain/entity/quote_entity.dart';

abstract class OwnQuotesEvent {
  const OwnQuotesEvent();
}

class GetOwnQuotes extends OwnQuotesEvent {}

class OnDeletePressed extends OwnQuotesEvent {
  final QuoteEntity entity;
  const OnDeletePressed(this.entity);
}

class SaveOwnQuote extends OwnQuotesEvent {
  final QuoteEntity entity;
  const SaveOwnQuote(this.entity);
}
