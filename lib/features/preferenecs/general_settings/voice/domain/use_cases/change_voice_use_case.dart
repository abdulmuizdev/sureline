import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/entity/voice_entity.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/repository/voice_repository.dart';

/// Use case for changing the current text-to-speech voice.
///
/// This use case encapsulates the business logic for updating the
/// selected voice setting. It follows the Clean Architecture pattern
/// by depending on the repository interface rather than concrete
/// implementations.
///
/// The use case returns an Either type for functional error handling,
/// where Left represents a failure and Right represents success.
class ChangeVoiceUseCase {
  final VoiceRepository voiceRepository;

  /// Creates a new ChangeVoiceUseCase instance.
  ///
  /// [voiceRepository] - The repository interface for voice operations
  const ChangeVoiceUseCase(this.voiceRepository);

  /// Executes the use case to change the current voice.
  ///
  /// This method calls the repository to update the TTS engine
  /// configuration with the new voice and persist the setting
  /// to storage.
  ///
  /// [entity] - The voice entity to be set as the current voice
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails (TTS engine error, storage error, etc.)
  /// - Right<void> - If the voice is successfully changed
  Future<Either<Failure, void>> execute(VoiceEntity entity) {
    return voiceRepository.changeVoice(entity);
  }
}
