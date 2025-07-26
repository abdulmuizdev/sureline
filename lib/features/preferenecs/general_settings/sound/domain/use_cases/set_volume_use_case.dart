import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/domain/repository/sound_repository.dart';

/// Use case for setting the volume to a specific value.
class SetVolumeUseCase {
  final SoundRepository repository;

  /// Creates a new SetVolumeUseCase instance.
  const SetVolumeUseCase(this.repository);

  /// Executes the use case to set the volume.
  Future<Either<Failure, void>> execute(double volume) {
    return repository.setVolume(volume);
  }
}
