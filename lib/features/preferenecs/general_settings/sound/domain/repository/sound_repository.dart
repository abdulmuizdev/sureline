import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';

abstract class SoundRepository {
  Future<Either<Failure, double>> getVolume();
  Future<Either<Failure, void>> setVolume(double volume);
}