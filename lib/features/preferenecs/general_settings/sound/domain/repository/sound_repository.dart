import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';

/// Abstract repository interface for sound operations.
abstract class SoundRepository {
  /// Retrieves the current volume setting.
  Future<Either<Failure, double>> getVolume();

  /// Sets the volume to the specified value.
  Future<Either<Failure, void>> setVolume(double volume);
}
