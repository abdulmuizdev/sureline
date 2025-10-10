import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/data/data_source/sound_data_source.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/domain/repository/sound_repository.dart';

/// Implementation of SoundRepository that handles sound operations.
class SoundRepositoryImpl implements SoundRepository {
  final SoundDataSource dataSource;

  /// Creates a new SoundRepositoryImpl instance.
  const SoundRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, double>> getVolume() {
    return dataSource.getVolume();
  }

  @override
  Future<Either<Failure, void>> setVolume(double volume) {
    return dataSource.setVolume(volume);
  }
}
