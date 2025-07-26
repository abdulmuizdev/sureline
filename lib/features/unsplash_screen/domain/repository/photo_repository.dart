import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/unsplash_screen/domain/entity/photo_entity.dart';

/// Repository interface for Unsplash photo operations.
///
/// Provides photo retrieval and search functionality with pagination support.
/// Handles Unsplash API integration for background image selection.
abstract class PhotoRepository {
  /// Retrieves photos from Unsplash with pagination.
  /// [page] - Page number for pagination
  /// Returns Either<Failure, List<PhotoEntity>> - Photos or error
  Future<Either<Failure, List<PhotoEntity>>> getPhotos(int page);

  /// Searches photos from Unsplash with query and pagination.
  /// [query] - Search term for photo filtering
  /// [page] - Page number for pagination
  /// Returns Either<Failure, List<PhotoEntity>> - Search results or error
  Future<Either<Failure, List<PhotoEntity>>> searchPhotos(String query, int page);
}
