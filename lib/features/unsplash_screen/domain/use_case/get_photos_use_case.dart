import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/unsplash_screen/domain/entity/photo_entity.dart';
import 'package:sureline/features/unsplash_screen/domain/repository/photo_repository.dart';

/// Use case for retrieving photos from Unsplash.
///
/// Encapsulates business logic for photo retrieval with pagination support.
/// Delegates to repository for data access and error handling.
class GetPhotosUseCase {
  final PhotoRepository repository;

  GetPhotosUseCase(this.repository);

  /// Executes photo retrieval with pagination.
  /// [page] - Page number for pagination
  /// Returns Either<Failure, List<PhotoEntity>> - Photos or error
  Future<Either<Failure, List<PhotoEntity>>> execute(int page) {
    return repository.getPhotos(page);
  }
}
