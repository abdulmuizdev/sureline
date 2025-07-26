import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/data/data_source/voice_data_source.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/data/model/voice_model.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/entity/voice_entity.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/repository/voice_repository.dart';

/// Implementation of VoiceRepository that handles voice data operations.
///
/// This class implements the VoiceRepository interface and provides
/// concrete implementations for all voice-related operations. It follows
/// the Clean Architecture pattern by depending on the data source interface
/// and converting between domain entities and data models.
///
/// The repository acts as a mediator between the domain layer and the data
/// layer, ensuring proper data transformation and error handling for
/// text-to-speech voice operations.
class VoiceRepositoryImpl implements VoiceRepository {
  final VoiceDataSource voiceDataSource;

  /// Creates a new VoiceRepositoryImpl instance.
  ///
  /// [voiceDataSource] - The data source for voice operations
  const VoiceRepositoryImpl(this.voiceDataSource);

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
    // Convert domain entity to data model and delegate to data source
    return voiceDataSource.changeVoice(VoiceModel.fromEntity(entity));
  }
}
