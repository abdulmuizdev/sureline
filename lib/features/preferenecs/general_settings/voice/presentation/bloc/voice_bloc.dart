import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/data/model/voice_model.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/entity/voice_entity.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/use_cases/change_voice_use_case.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/use_cases/get_voices_use_case.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/presentation/bloc/voice_event.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/presentation/bloc/voice_state.dart';

/// Bloc for managing voice-related state and business logic.
///
/// This bloc handles all operations related to text-to-speech voice
/// settings, including retrieving available voices, changing the
/// selected voice, and managing voice preferences. It follows the
/// Clean Architecture pattern by delegating business logic to use cases.
///
/// The bloc maintains the current state of voice settings and handles
/// voice selection from the UI, updating the TTS engine configuration
/// and persisting preferences to storage.
class VoiceBloc extends Bloc<VoiceEvent, VoiceState> {
  final GetVoicesUseCase _getVoicesUseCase;
  final ChangeVoiceUseCase _changeVoiceUseCase;

  /// Creates a new VoiceBloc instance.
  ///
  /// [getVoicesUseCase] - Use case for retrieving available voices
  /// [changeVoiceUseCase] - Use case for changing the selected voice
  VoiceBloc({
    required GetVoicesUseCase getVoicesUseCase,
    required ChangeVoiceUseCase changeVoiceUseCase,
  }) : _getVoicesUseCase = getVoicesUseCase,
       _changeVoiceUseCase = changeVoiceUseCase,
       super(const Initial()) {
    on<GetVoices>((event, emit) async {
      await _getVoices(emit);
    });

    on<OnVoiceItemPressed>((event, emit) async {
      await _changeVoice(event.entity);
    });
  }

  /// Retrieves available voices and emits the appropriate state.
  ///
  /// This method calls the get voices use case and handles the result.
  /// On success, it finds the currently selected voice and emits
  /// GotVoices with the list and selected index. On failure, it
  /// emits VoiceError with the error message.
  ///
  /// [emit] - The emitter for state changes
  Future<void> _getVoices(Emitter<VoiceState> emit) async {
    emit(const GettingVoices());
    final result = await _getVoicesUseCase.execute();
    result.fold(
      (left) {
        emit(VoiceError(left.message));
      },
      (right) {
        // Find the currently selected voice by comparing with App.voice
        int selectedIndex = 0;
        for (int i = 0; i < right.length; i++) {
          debugPrint('checking ${VoiceModel.fromEntity(right[i]).toJson()} with ${App.voice}');
          debugPrint('');
          if (VoiceModel.fromEntity(right[i]).toJson().toString() == App.voice.toString()) {
            debugPrint('found it');
            selectedIndex = i;
          }
        }
        emit(GotVoices(right, selectedIndex));
      },
    );
  }

  /// Changes the current voice to the specified entity.
  ///
  /// This method calls the change voice use case to update the
  /// TTS engine configuration and persist the new voice setting.
  ///
  /// [entity] - The voice entity to be set as the current voice
  Future<void> _changeVoice(VoiceEntity entity) async {
    await _changeVoiceUseCase.execute(entity);
  }
}
