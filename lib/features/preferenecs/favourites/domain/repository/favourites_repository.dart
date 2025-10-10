import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/common/domain/entities/collections/favourite_entity.dart';
import 'package:sureline/common/domain/entities/collections/history_entity.dart';
import 'package:sureline/common/domain/entities/collections/own_quote_entity.dart';
import 'package:sureline/common/domain/entities/recommendation_algorithm/quote_entity.dart';
import 'package:sureline/common/domain/entities/collections/search_entity.dart';

/// Abstract repository interface for favourites operations.
///
/// This repository defines the contract for all favourites-related data operations,
/// including retrieving favourites, adding new favourites, removing favourites,
/// and getting the count of favourites. It follows the Clean Architecture pattern
/// by providing a clean interface that the domain layer depends on.
///
/// The repository handles different types of quotes that can be favourited:
/// - Regular quotes from the recommendation algorithm
/// - User's own quotes
/// - Quotes from search results
/// - Quotes from browsing history
abstract class FavouritesRepository {
  /// Retrieves all favourite quotes for the current user.
  ///
  /// This method fetches all quotes that the user has marked as favourites
  /// from the data source and returns them as a list of FavouriteEntity objects.
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails (database error, network issue, etc.)
  /// - Right<List<FavouriteEntity>> - If the operation succeeds with the favourites list
  Future<Either<Failure, List<FavouriteEntity>>> getFavourites();

  /// Adds a quote to the user's favourites.
  ///
  /// This method allows adding different types of quotes to favourites:
  /// - Regular quotes from the recommendation system
  /// - User's own custom quotes
  /// - Quotes from search results
  /// - Quotes from browsing history
  ///
  /// Only one of the parameters should be provided at a time, as each
  /// represents a different type of quote that can be favourited.
  ///
  /// [quote] - Regular quote from recommendation algorithm
  /// [ownQuote] - User's own custom quote
  /// [history] - Quote from browsing history
  /// [search] - Quote from search results
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails
  /// - Right<void> - If the quote is successfully added to favourites
  Future<Either<Failure, void>> addFavourite({
    QuoteEntity? quote,
    OwnQuoteEntity? ownQuote,
    HistoryEntity? history,
    SearchEntity? search,
  });

  /// Removes a quote from the user's favourites.
  ///
  /// This method removes a quote from favourites based on its ID.
  /// The method accepts different types of IDs depending on the source
  /// of the favourited quote.
  ///
  /// [quoteId] - ID of a regular quote
  /// [ownQuoteId] - ID of a user's own quote
  /// [historyId] - ID of a quote from history
  /// [searchId] - ID of a quote from search results
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails
  /// - Right<void> - If the quote is successfully removed from favourites
  Future<Either<Failure, void>> removeFavourite({
    int? quoteId,
    int? ownQuoteId,
    int? historyId,
    int? searchId,
  });

  /// Gets the total count of user's favourite quotes.
  ///
  /// This method returns the number of quotes that the user has
  /// marked as favourites, useful for displaying counts in the UI.
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails
  /// - Right<int> - The count of favourite quotes
  Future<Either<Failure, int>> getFavouritesCount();
}
