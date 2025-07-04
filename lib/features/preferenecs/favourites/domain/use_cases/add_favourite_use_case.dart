import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/favourites/domain/repository/favourites_repository.dart';
import 'package:sureline/features/preferenecs/history/domain/entity/history_entity.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/entity/own_quote_entity.dart';
import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';
import 'package:sureline/features/preferenecs/search/domain/entity/search_entity.dart';

class AddFavouriteUseCase {
  final FavouritesRepository repository;

  AddFavouriteUseCase(this.repository);

  Future<Either<Failure, void>> call({
    QuoteEntity? quote,
    OwnQuoteEntity? ownQuote,
    HistoryEntity? history,
    SearchEntity? search,
  }) async {
    return repository.addFavourite(
      quote: quote,
      ownQuote: ownQuote,
      history: history,
      search: search,
    );
  }
}
