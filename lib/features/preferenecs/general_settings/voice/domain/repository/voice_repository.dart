import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/entity/voice_entity.dart';

/// Abstract repository interface for voice operations.
///
/// This repository defines the contract for all voice-related data operations,
/// including retrieving available voices, getting the current voice setting,
/// and changing the selected voice. It follows the Clean Architecture pattern
/// by providing a clean interface that the domain layer depends on.
///
/// The repository handles interactions with the device's text-to-speech
/// engine and manages voice preferences persistence.
abstract class VoiceRepository {
  /// Retrieves all available voices from the TTS engine.
  ///
  /// This method fetches all available text-to-speech voices from
  /// the device's TTS engine and returns them as a list of VoiceEntity
  /// objects. The voices are typically filtered to show only English
  /// voices and sorted by locale.
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails (TTS engine error, etc.)
  /// - Right<List<VoiceEntity>> - If the operation succeeds with the voices list
  Future<Either<Failure, List<VoiceEntity>>> getVoices();

  /// Retrieves the currently selected voice from preferences.
  ///
  /// This method loads the user's saved voice preference from
  /// persistent storage and returns the corresponding VoiceEntity.
  /// If no voice has been selected, it returns null.
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails (storage error, etc.)
  /// - Right<VoiceEntity?> - If the operation succeeds with the current voice (or null)
  Future<Either<Failure, VoiceEntity?>> getVoice();

  /// Changes the current voice to the specified entity.
  ///
  /// This method updates the TTS engine configuration with the new
  /// voice and persists the selection to storage. It also provides
  /// a voice preview to confirm the selection.
  ///
  /// [model] - The voice entity to be set as the current voice
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails (TTS engine error, storage error, etc.)
  /// - Right<void> - If the voice is successfully changed
  Future<Either<Failure, void>> changeVoice(VoiceEntity model);
}
