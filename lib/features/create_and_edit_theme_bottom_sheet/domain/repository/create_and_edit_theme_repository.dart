import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';

abstract class CreateThemeRepository {
  Future<Either<Failure, String>> downloadPhoto(String path);
}