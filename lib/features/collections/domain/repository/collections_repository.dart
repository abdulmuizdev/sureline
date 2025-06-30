import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/own_quotes/domain/entity/own_quote_entity.dart';

abstract class CollectionsRepository {
  Future<Either<Failure, List<CollectionEntity>>> getCollections();
  Future<Either<Failure, void>> saveCollection(CollectionEntity collection);
  Future<Either<Failure, void>> removeCollection(CollectionEntity collection);
  Future<Either<Failure, void>> addQuoteToCollection(
    int collectionId,
    int favouriteId,
  );
  Future<Either<Failure, void>> removeQuoteFromCollection(
    int collectionId,
    int favouriteId,
  );
  Future<Either<Failure, List<FavouriteEntity>>> getFavouritesOfCollection(
    int collectionId,
  );
  Future<Either<Failure, List<CollectionEntity>>> getCollectionsOfFavourite(
    int favouriteId,
  );
  Future<Either<Failure, void>> addOwnQuoteToCollection(
    int collectionId,
    int ownQuoteId,
  );
  Future<Either<Failure, void>> removeOwnQuoteFromCollection(
    int collectionId,
    int ownQuoteId,
  );
  Future<Either<Failure, List<OwnQuoteEntity>>> getOwnQuotesOfCollection(
    int collectionId,
  );
  Future<Either<Failure, List<CollectionEntity>>> getCollectionsOfOwnQuote(
    int ownQuoteId,
  );
}
