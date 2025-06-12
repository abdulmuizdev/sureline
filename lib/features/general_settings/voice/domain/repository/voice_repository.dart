import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/voice/domain/entity/voice_entity.dart';

abstract class VoiceRepository {
  Future<Either<Failure, List<VoiceEntity>>> getVoices();
  Future<Either<Failure, VoiceEntity?>> getVoice();
  Future<Either<Failure, void>> changeVoice(VoiceEntity model);
}