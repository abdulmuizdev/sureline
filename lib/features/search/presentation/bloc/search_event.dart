import 'package:sureline/features/home/domain/entity/quote_entity.dart';

abstract class SearchEvent {
  const SearchEvent();
}

class OnSearchTextChanged extends SearchEvent {
  final String query;
  final int page;

  OnSearchTextChanged(this.query, this.page);
}

// class GetQuotes extends SearchEvent {
//   GetQuotes();
// }

class SearchQuote extends SearchEvent {
  final String query;
  final int page;

  SearchQuote(this.query, this.page);
}

class OnLikePressed extends SearchEvent {
  final bool isLiked;
  final QuoteEntity entity;
  const OnLikePressed(this.isLiked, this.entity);
}
