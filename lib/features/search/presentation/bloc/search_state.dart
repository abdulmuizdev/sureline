import 'package:sureline/features/home/domain/entity/quote_entity.dart';

abstract class SearchState{
  const SearchState();
}

class Initial extends SearchState{
  const Initial();
}

class SearchingQuotes extends SearchState {

}

class SearchedQuotes extends SearchState {
  final List<QuoteEntity> result;
  const SearchedQuotes(this.result);
}

class GotQuotes extends SearchState {
  final List<QuoteEntity> result;
  const GotQuotes(this.result);
}