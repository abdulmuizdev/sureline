import 'package:sureline/features/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/history/domain/entity/history_entity.dart';
import 'package:sureline/features/home/domain/entity/quote_entity.dart';
import 'package:sureline/features/own_quotes/domain/entity/own_quote_entity.dart';
import 'package:sureline/features/search/domain/entity/search_entity.dart';

abstract class CollectionsState {
  const CollectionsState();
}

class Initial extends CollectionsState {}

class GotCollections extends CollectionsState {
  final List<CollectionEntity>? collections;
  const GotCollections(this.collections);
}

class GotFavouritesOfCollection extends CollectionsState {
  final List<FavouriteEntity>? favourites;
  const GotFavouritesOfCollection(this.favourites);
}

class GotOwnQuotesOfCollection extends CollectionsState {
  final List<OwnQuoteEntity>? ownQuotes;
  const GotOwnQuotesOfCollection(this.ownQuotes);
}

class GotHistoryOfCollection extends CollectionsState {
  final List<HistoryEntity>? history;
  const GotHistoryOfCollection(this.history);
}

class GotSearchOfCollection extends CollectionsState {
  final List<SearchEntity>? search;
  const GotSearchOfCollection(this.search);
}

class GotCollectionsOfFavourite extends CollectionsState {
  final List<CollectionEntity>? collections;
  const GotCollectionsOfFavourite(this.collections);
}

class GotCollectionsOfOwnQuote extends CollectionsState {
  final List<CollectionEntity>? collections;
  const GotCollectionsOfOwnQuote(this.collections);
}

class GotCollectionsOfHistory extends CollectionsState {
  final List<CollectionEntity>? collections;
  const GotCollectionsOfHistory(this.collections);
}

class GotCollectionsOfSearch extends CollectionsState {
  final List<CollectionEntity>? collections;
  const GotCollectionsOfSearch(this.collections);
}

class GotFavouritesOfCollectionAndCollectionsOfFavourite
    extends CollectionsState {
  final List<FavouriteEntity> favourites;
  final List<CollectionEntity> collections;
  const GotFavouritesOfCollectionAndCollectionsOfFavourite(
    this.favourites,
    this.collections,
  );
}

class GotOwnQuotesOfCollectionAndCollectionsOfOwnQuote
    extends CollectionsState {
  final List<OwnQuoteEntity> ownQuotes;
  final List<CollectionEntity> collections;
  const GotOwnQuotesOfCollectionAndCollectionsOfOwnQuote(
    this.ownQuotes,
    this.collections,
  );
}

class GotHistoryOfCollectionAndCollectionsOfHistory extends CollectionsState {
  final List<HistoryEntity> history;
  final List<CollectionEntity> collections;
  const GotHistoryOfCollectionAndCollectionsOfHistory(
    this.history,
    this.collections,
  );
}

class GotSearchOfCollectionAndCollectionsOfSearch extends CollectionsState {
  final List<SearchEntity> search;
  final List<CollectionEntity> collections;
  const GotSearchOfCollectionAndCollectionsOfSearch(
    this.search,
    this.collections,
  );
}

class SavedCollection extends CollectionsState {
  final List<CollectionEntity> collections;
  const SavedCollection(this.collections);
}
