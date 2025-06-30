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

class OnAddToCollectionPressed extends CollectionsEvent {
  final int collectionId;
  final int? favouriteId;
  final int? ownQuoteId;
  final bool isSelected;

  const OnAddToCollectionPressed({
    required this.collectionId,
    required this.isSelected,
    this.favouriteId,
    this.ownQuoteId,
  });
}
