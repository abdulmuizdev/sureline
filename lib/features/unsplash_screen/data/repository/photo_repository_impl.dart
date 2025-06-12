import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/unsplash_screen/data/data_source/photo_data_source.dart';
import 'package:sureline/features/unsplash_screen/domain/entity/photo_entity.dart';
import 'package:sureline/features/unsplash_screen/domain/repository/photo_repository.dart';

class PhotoRepositoryImpl extends PhotoRepository {
  final PhotoDataSource dataSource;

  PhotoRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<PhotoEntity>>> getPhotos(int page) {
    return dataSource.getPhotos(page);
  }

  @override
  Future<Either<Failure, List<PhotoEntity>>> searchPhotos(String query, int page) {
    return dataSource.searchPhotos(query, page);
  }
}
