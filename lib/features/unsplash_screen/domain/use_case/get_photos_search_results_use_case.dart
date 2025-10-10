import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/unsplash_screen/domain/entity/photo_entity.dart';
import 'package:sureline/features/unsplash_screen/domain/repository/photo_repository.dart';

/// Use case for searching photos from Unsplash.
///
/// Encapsulates business logic for photo search with query and pagination.
/// Delegates to repository for data access and error handling.
class GetPhotosSearchResultsUseCase {
  final PhotoRepository repository;

  GetPhotosSearchResultsUseCase(this.repository);

  /// Executes photo search with query and pagination.
  /// [query] - Search term for photo filtering
  /// [page] - Page number for pagination
  /// Returns Either<Failure, List<PhotoEntity>> - Search results or error
  Future<Either<Failure, List<PhotoEntity>>> execute(String query, int page) {
    return repository.searchPhotos(query, page);
  }
}
