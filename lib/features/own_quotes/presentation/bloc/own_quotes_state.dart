import 'package:sureline/features/home/domain/entity/quote_entity.dart';

abstract class OwnQuotesState {
  const OwnQuotesState();
}

class Initial extends OwnQuotesState {}

class GotOwnQuotes extends OwnQuotesState {
  final List<QuoteEntity>? ownQuotes;
  const GotOwnQuotes(this.ownQuotes);
}
