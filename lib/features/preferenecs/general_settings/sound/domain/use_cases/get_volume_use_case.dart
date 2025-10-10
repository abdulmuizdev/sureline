import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/domain/repository/sound_repository.dart';

/// Use case for retrieving the current volume setting.
class GetVolumeUseCase {
  final SoundRepository repository;

  /// Creates a new GetVolumeUseCase instance.
  const GetVolumeUseCase(this.repository);

  /// Executes the use case to retrieve the volume.
  Future<Either<Failure, double>> execute() {
    return repository.getVolume();
  }
}
