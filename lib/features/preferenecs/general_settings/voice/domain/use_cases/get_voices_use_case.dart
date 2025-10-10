import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/entity/voice_entity.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/repository/voice_repository.dart';

/// Use case for retrieving all available text-to-speech voices.
///
/// This use case encapsulates the business logic for fetching available
/// voices from the device's TTS engine. It follows the Clean Architecture
/// pattern by depending on the repository interface rather than concrete
/// implementations.
///
/// The use case returns an Either type for functional error handling,
/// where Left represents a failure and Right represents success with the
/// list of available voice entities.
class GetVoicesUseCase {
  final VoiceRepository voiceRepository;

  /// Creates a new GetVoicesUseCase instance.
  ///
  /// [voiceRepository] - The repository interface for voice operations
  const GetVoicesUseCase(this.voiceRepository);

  /// Executes the use case to retrieve all available voices.
  ///
  /// This method calls the repository to fetch all available voices
  /// from the device's TTS engine and returns the result wrapped in
  /// an Either type for proper error handling.
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails (TTS engine error, etc.)
  /// - Right<List<VoiceEntity>> - If the operation succeeds with the voices list
  Future<Either<Failure, List<VoiceEntity>>> execute() {
    return voiceRepository.getVoices();
  }
}
