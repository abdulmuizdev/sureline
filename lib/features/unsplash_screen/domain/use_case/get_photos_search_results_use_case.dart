import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/unsplash_screen/domain/entity/photo_entity.dart';
import 'package:sureline/features/unsplash_screen/domain/repository/photo_repository.dart';

class GetPhotosSearchResultsUseCase {
  final PhotoRepository repository;

  GetPhotosSearchResultsUseCase(this.repository);

  Future<Either<Failure, List<PhotoEntity>>> execute(String query, int page){
    return repository.searchPhotos(query, page);
  }
}