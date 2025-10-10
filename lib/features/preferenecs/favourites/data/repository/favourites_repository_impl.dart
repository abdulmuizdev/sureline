import 'package:dartz/dartz.dart';
import 'package:sureline/common/data/model/collections/history_model.dart';
import 'package:sureline/common/data/model/collections/own_quote_model.dart';
import 'package:sureline/common/data/model/collections/search_model.dart';
import 'package:sureline/common/data/model/quote_model.dart';
import 'package:sureline/common/domain/entities/collections/favourite_entity.dart';
import 'package:sureline/common/domain/entities/collections/history_entity.dart';
import 'package:sureline/common/domain/entities/collections/own_quote_entity.dart';
import 'package:sureline/common/domain/entities/collections/search_entity.dart';
import 'package:sureline/common/domain/entities/recommendation_algorithm/quote_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/favourites/data/data_source/favourites_data_source.dart';
import 'package:sureline/features/preferenecs/favourites/domain/repository/favourites_repository.dart';

/// Implementation of FavouritesRepository that handles favourites data operations.
///
/// This class implements the FavouritesRepository interface and provides
/// concrete implementations for all favourites-related operations. It follows
/// the Clean Architecture pattern by depending on the data source interface
/// and converting between domain entities and data models.
///
/// The repository acts as a mediator between the domain layer and the data
/// layer, ensuring proper data transformation and error handling.
class FavouritesRepositoryImpl extends FavouritesRepository {
  final FavouritesDataSource dataSource;

  /// Creates a new FavouritesRepositoryImpl instance.
  ///
  /// [dataSource] - The data source for favourites operations
  FavouritesRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<FavouriteEntity>>> getFavourites() async {
    return dataSource.getFavourites();
  }

  @override
  Future<Either<Failure, void>> addFavourite({
    QuoteEntity? quote,
    OwnQuoteEntity? ownQuote,
    HistoryEntity? history,
    SearchEntity? search,
  }) async {
    // Convert domain entities to data models and delegate to data source
    if (quote != null) {
      print('checkk 1');
      return dataSource.addFavourite(quote: QuoteModel.fromEntity(quote));
    } else if (ownQuote != null) {
      print('checkk 2');
      return dataSource.addFavourite(ownQuote: OwnQuoteModel.fromEntity(ownQuote));
    } else if (search != null) {
      print('checkk 3');
      return dataSource.addFavourite(search: SearchModel.fromEntity(search));
    } else if (history != null) {
      print('checkk 4');
      return dataSource.addFavourite(history: HistoryModel.fromEntity(history));
    } else {
      // Return failure if no valid entity is provided
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeFavourite({
    int? quoteId,
    int? ownQuoteId,
    int? historyId,
    int? searchId,
  }) async {
    // Delegate the removal operation to the data source
    return dataSource.removeFavourite(
      quoteId: quoteId,
      ownQuoteId: ownQuoteId,
      historyId: historyId,
      searchId: searchId,
    );
  }

  @override
  Future<Either<Failure, int>> getFavouritesCount() async {
    return dataSource.getFavouritesCount();
  }
}
