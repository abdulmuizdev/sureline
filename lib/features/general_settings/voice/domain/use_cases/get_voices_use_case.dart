import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/voice/domain/entity/voice_entity.dart';
import 'package:sureline/features/general_settings/voice/domain/repository/voice_repository.dart';

class GetVoicesUseCase {
  final VoiceRepository voiceRepository;
  GetVoicesUseCase(this.voiceRepository);

  Future<Either<Failure, List<VoiceEntity>>> execute(){
    return voiceRepository.getVoices();
  }
}