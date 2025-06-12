import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/sound/domain/repository/sound_repository.dart';

class GetVolumeUseCase {
  final SoundRepository repository;
  GetVolumeUseCase(this.repository);

  Future<Either<Failure, double>> execute(){
    return repository.getVolume();
  }
}