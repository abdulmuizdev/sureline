import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/favourite_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/favourites/domain/repository/favourites_repository.dart';

/// Use case for retrieving all user's favourite quotes.
///
/// This use case encapsulates the business logic for fetching favourite quotes
/// from the data source. It follows the Clean Architecture pattern by
/// depending on the repository interface rather than concrete implementations.
///
/// The use case returns an Either type for functional error handling,
/// where Left represents a failure and Right represents success with the
/// list of favourite quotes.
class GetFavouritesUseCase {
  final FavouritesRepository repository;

  /// Creates a new GetFavouritesUseCase instance.
  ///
  /// [repository] - The repository interface for data operations
  GetFavouritesUseCase(this.repository);

  /// Executes the use case to retrieve all favourite quotes.
  ///
  /// This method calls the repository to fetch all favourite quotes
  /// and returns the result wrapped in an Either type for proper
  /// error handling.
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails (network, database, etc.)
  /// - Right<List<FavouriteEntity>> - If the operation succeeds with the quotes
  Future<Either<Failure, List<FavouriteEntity>>> call() async {
    return repository.getFavourites();
  }
}
