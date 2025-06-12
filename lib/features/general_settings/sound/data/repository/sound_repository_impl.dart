import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/sound/data/data_source/sound_data_source.dart';
import 'package:sureline/features/general_settings/sound/domain/repository/sound_repository.dart';

class SoundRepositoryImpl extends SoundRepository {
  final SoundDataSource dataSource;
  SoundRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, double>> getVolume() {
    return dataSource.getVolume();
  }

  @override
  Future<Either<Failure, void>> setVolume(double volume) {
    return dataSource.setVolume(volume);
  }

}