import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/domain/use_cases/get_volume_use_case.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/domain/use_cases/set_volume_use_case.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/presentation/bloc/sound_event.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/presentation/bloc/sound_state.dart';

/// Bloc for managing sound-related state and business logic.
///
/// This bloc handles all operations related to volume settings,
/// including retrieving and saving volume preferences. It follows
/// the Clean Architecture pattern by delegating business logic
/// to use cases and emitting appropriate states for UI updates.
///
/// The bloc maintains the current state of volume settings and
/// handles volume changes from the UI, persisting them to storage.
class SoundBloc extends Bloc<SoundEvent, SoundState> {
  final GetVolumeUseCase _getVolumeUseCase;
  final SetVolumeUseCase _setVolumeUseCase;

  /// Creates a new SoundBloc instance.
  ///
  /// [getVolumeUseCase] - Use case for retrieving volume settings
  /// [setVolumeUseCase] - Use case for saving volume settings
  SoundBloc({
    required GetVolumeUseCase getVolumeUseCase,
    required SetVolumeUseCase setVolumeUseCase,
  }) : _getVolumeUseCase = getVolumeUseCase,
       _setVolumeUseCase = setVolumeUseCase,
       super(const Initial()) {
    on<GetVolume>((event, emit) async {
      await _getVolume(emit);
    });

    on<SetVolume>((event, emit) async {
      await _setVolume(event.volume, emit);
    });
  }

  /// Retrieves the current volume setting and emits the appropriate state.
  ///
  /// This method calls the get volume use case and handles the result.
  /// On success, it emits GotVolume with the retrieved volume value.
  /// On failure, it maintains the current state (error handling could be
  /// enhanced to emit specific error states).
  ///
  /// [emit] - The emitter for state changes
  Future<void> _getVolume(Emitter<SoundState> emit) async {
    final result = await _getVolumeUseCase.execute();
    result.fold((left) {}, (right) {
      emit(GotVolume(right));
    });
  }

  /// Saves the new volume setting and emits the appropriate state.
  ///
  /// This method calls the set volume use case and handles the result.
  /// On success, it emits SetVolumeCompleted to indicate the save
  /// operation was successful.
  ///
  /// [volume] - The volume value to be saved (0.0 to 1.0)
  /// [emit] - The emitter for state changes
  Future<void> _setVolume(double volume, Emitter<SoundState> emit) async {
    final result = await _setVolumeUseCase.execute(volume);
    result.fold((left) {}, (right) {
      emit(const SetVolumeCompleted());
    });
  }
}
