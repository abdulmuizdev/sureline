import 'package:sureline/features/search/domain/entity/search_entity.dart';

abstract class SearchState {
  const SearchState();
}

class Initial extends SearchState {
  const Initial();
}

class SearchingQuotes extends SearchState {}

class SearchedQuotes extends SearchState {
  final List<SearchEntity> result;
  const SearchedQuotes(this.result);
}

class GotSearch extends SearchState {
  final List<SearchEntity> result;
  const GotSearch(this.result);
}
