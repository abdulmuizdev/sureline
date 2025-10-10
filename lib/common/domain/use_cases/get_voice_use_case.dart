/// Voice settings use cases for the Sureline app.
///
/// This file contains the use case for retrieving voice settings
/// within the Sureline app. The [GetVoiceUseCase] encapsulates
/// the business logic for getting the user's current voice configuration.
///
/// Key Features:
/// - Clean Architecture use case pattern
/// - Dependency injection with repository
/// - Functional error handling with Either
/// - Nullable voice entity result
///
/// Usage:
/// ```dart
/// final useCase = GetVoiceUseCase(voiceRepository);
/// final result = await useCase.execute();
/// result.fold(
///   (failure) => handleError(failure),
///   (voiceEntity) => handleVoiceSettings(voiceEntity),
/// );
/// ```

import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/entity/voice_entity.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/repository/voice_repository.dart';

/// Use case for getting the current voice settings.
///
/// This use case handles the business logic for retrieving
/// the user's current voice configuration. It follows the Clean
/// Architecture pattern by encapsulating the business rules and
/// delegating data operations to the repository layer.
///
/// Responsibilities:
/// - Retrieve current voice settings
/// - Coordinate with voice repository
/// - Handle success and failure scenarios
/// - Provide clean interface for presentation layer
///
/// Dependencies:
/// - [VoiceRepository]: For voice settings data operations
///
/// Returns: [Either<Failure, VoiceEntity?>] containing the voice entity or failure
class GetVoiceUseCase {
  /// The voice repository dependency.
  ///
  /// Used to retrieve voice settings from persistent storage.
  final VoiceRepository voiceRepository;

  /// Creates an instance of [GetVoiceUseCase].
  ///
  /// [voiceRepository]: The voice repository for voice settings operations
  const GetVoiceUseCase(this.voiceRepository);

  /// Executes the use case to get voice settings.
  ///
  /// This method encapsulates the business logic for retrieving
  /// the user's current voice configuration. It delegates the actual
  /// voice settings retrieval to the repository and returns a functional
  /// result containing the voice entity or failure.
  ///
  /// Returns: [Either<Failure, VoiceEntity?>] containing the voice entity or failure
  /// - Success: VoiceEntity if settings exist, null if no settings configured
  /// - Failure: if there was an error retrieving the settings
  ///
  /// Example:
  /// ```dart
  /// final result = await useCase.execute();
  /// result.fold(
  ///   (failure) => print('Failed to get voice settings: ${failure.message}'),
  ///   (voiceEntity) => print('Voice settings: ${voiceEntity?.name ?? 'Not set'}'),
  /// );
  /// ```
  Future<Either<Failure, VoiceEntity?>> execute() {
    return voiceRepository.getVoice();
  }
}
