import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';

abstract class FavouritesRepository {
  Future<Either<Failure, List<FavouriteEntity>>> getFavourites();
  Future<Either<Failure, void>> addFavourite(QuoteEntity quote);
  Future<Either<Failure, void>> removeFavourite(int id);
  Future<Either<Failure, int>> getFavouritesCount();
}
