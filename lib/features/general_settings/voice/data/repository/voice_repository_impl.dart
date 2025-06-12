import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/voice/data/data_source/voice_data_source.dart';
import 'package:sureline/features/general_settings/voice/data/model/voice_model.dart';
import 'package:sureline/features/general_settings/voice/domain/entity/voice_entity.dart';
import 'package:sureline/features/general_settings/voice/domain/repository/voice_repository.dart';

class VoiceRepositoryImpl extends VoiceRepository {
  final VoiceDataSource voiceDataSource;

  VoiceRepositoryImpl(this.voiceDataSource);

  @override
  Future<Either<Failure, List<VoiceEntity>>> getVoices() {
    return voiceDataSource.getVoices();
  }

  @override
  Future<Either<Failure, VoiceEntity?>> getVoice() {
    return voiceDataSource.getVoice();
  }

  @override
  Future<Either<Failure, void>> changeVoice(VoiceEntity entity) {
    return voiceDataSource.changeVoice(VoiceModel.fromEntity(entity));
  }
}
