import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/voice/domain/entity/voice_entity.dart';
import 'package:sureline/features/general_settings/voice/domain/repository/voice_repository.dart';

class ChangeVoiceUseCase {
  final VoiceRepository voiceRepository;
  ChangeVoiceUseCase(this.voiceRepository);

  Future<Either<Failure, void>> execute(VoiceEntity entity){
    return voiceRepository.changeVoice(entity);
  }
}