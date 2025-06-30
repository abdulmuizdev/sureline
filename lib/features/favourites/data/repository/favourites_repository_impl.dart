import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/favourites/data/data_source/favourites_data_source.dart';
import 'package:sureline/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/favourites/domain/repository/favourites_repository.dart';
import 'package:sureline/features/recommendation_algorithm/data/model/quote_model.dart';
import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';

class FavouritesRepositoryImpl extends FavouritesRepository {
  final FavouritesDataSource dataSource;

  FavouritesRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<FavouriteEntity>>> getFavourites() async {
    return dataSource.getFavourites();
  }

  @override
  Future<Either<Failure, void>> addFavourite(QuoteEntity quote) async {
    return dataSource.addFavourite(QuoteModel.fromEntity(quote));
  }

  @override
  Future<Either<Failure, void>> removeFavourite(int id) async {
    return dataSource.removeFavourite(id);
  }

  @override
  Future<Either<Failure, int>> getFavouritesCount() async {
    return dataSource.getFavouritesCount();
  }
}
