import 'package:sureline/features/collections/domain/entity/collection_entity.dart';

abstract class CollectionsEvent {
  const CollectionsEvent();
}

class GetCollections extends CollectionsEvent {}

class GetFavouritesOfCollection extends CollectionsEvent {
  final int id;
  const GetFavouritesOfCollection(this.id);
}

class GetOwnQuotesOfCollection extends CollectionsEvent {
  final int id;
  const GetOwnQuotesOfCollection(this.id);
}

class GetHistoryOfCollection extends CollectionsEvent {
  final int collectionId;
  const GetHistoryOfCollection(this.collectionId);
}

class GetSearchOfCollection extends CollectionsEvent {
  final int collectionId;
  const GetSearchOfCollection(this.collectionId);
}

class OnDeletePressed extends CollectionsEvent {
  final CollectionEntity entity;
  const OnDeletePressed(this.entity);
}

class SaveCollection extends CollectionsEvent {
  final CollectionEntity entity;
  const SaveCollection(this.entity);
}

class OnDeleteQuotePressed extends CollectionsEvent {
  final int favouriteId;
  final int collectionId;
  const OnDeleteQuotePressed(this.favouriteId, this.collectionId);
}

class GetCollectionsOfFavourite extends CollectionsEvent {
  final int favouriteId;
  const GetCollectionsOfFavourite(this.favouriteId);
}

class GetCollectionsOfOwnQuote extends CollectionsEvent {
  final int ownQuoteId;
  const GetCollectionsOfOwnQuote(this.ownQuoteId);
}

class GetCollectionsOfHistory extends CollectionsEvent {
  final int quoteId;
  const GetCollectionsOfHistory(this.quoteId);
}

class GetCollectionsOfSearch extends CollectionsEvent {
  final int searchId;
  const GetCollectionsOfSearch(this.searchId);
}

class OnAddToCollectionPressed extends CollectionsEvent {
  final int collectionId;
  final int? favouriteId;
  final int? ownQuoteId;
  final int? quoteId;
  final int? searchId;
  final bool isSelected;

  const OnAddToCollectionPressed({
    required this.collectionId,
    required this.isSelected,
    this.favouriteId,
    this.ownQuoteId,
    this.quoteId,
    this.searchId,
  });
}
