import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';
import 'package:sureline/features/preferenecs/search/domain/entity/search_entity.dart';

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
  final SearchEntity entity;
  const OnLikePressed(this.isLiked, this.entity);
}
