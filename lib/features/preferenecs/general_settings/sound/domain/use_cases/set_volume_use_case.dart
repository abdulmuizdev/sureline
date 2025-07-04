import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/domain/repository/sound_repository.dart';

class SetVolumeUseCase {
  final SoundRepository repository;
  SetVolumeUseCase(this.repository);

  Future<Either<Failure, void>> execute(double volume){
    return repository.setVolume(volume);
  }
}