import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/unsplash_screen/domain/entity/photo_entity.dart';

abstract class PhotoRepository {
  Future<Either<Failure, List<PhotoEntity>>> getPhotos(int page);
  Future<Either<Failure, List<PhotoEntity>>> searchPhotos(String query, int page);
}