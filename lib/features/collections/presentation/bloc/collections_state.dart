import 'package:sureline/features/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/own_quotes/domain/entity/own_quote_entity.dart';

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

class GotCollectionsOfFavourite extends CollectionsState {
  final List<CollectionEntity>? collections;
  const GotCollectionsOfFavourite(this.collections);
}

class GotCollectionsOfOwnQuote extends CollectionsState {
  final List<CollectionEntity>? collections;
  const GotCollectionsOfOwnQuote(this.collections);
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

class SavedCollection extends CollectionsState {
  final List<CollectionEntity> collections;
  const SavedCollection(this.collections);
}
