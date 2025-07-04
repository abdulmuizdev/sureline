import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/entity/voice_entity.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/repository/voice_repository.dart';

class GetVoiceUseCase {
  final VoiceRepository voiceRepository;
  GetVoiceUseCase(this.voiceRepository);

  Future<Either<Failure, VoiceEntity?>> execute(){
    return voiceRepository.getVoice();
  }
}