/// Abstract base class for all sound-related events.
///
/// Events are dispatched to the SoundBloc to trigger state changes
/// and business logic operations in the sound settings feature.
/// This feature allows users to adjust volume settings for theme
/// sounds and other audio elements in the app.
abstract class SoundEvent {
  const SoundEvent();
}

/// Event to retrieve the current volume setting.
///
/// This event triggers the loading of the user's saved volume
/// setting from persistent storage. The bloc will emit GotVolume
/// state with the retrieved volume value (0.0 to 1.0).
class GetVolume extends SoundEvent {
  const GetVolume();
}

/// Event to set the volume to a specific value.
///
/// This event is dispatched when the user adjusts the volume slider
/// in the sound settings screen. The bloc will save the new volume
/// setting to persistent storage and emit SetVolumeCompleted state.
///
/// [volume] - The volume value to be set (0.0 to 1.0)
class SetVolume extends SoundEvent {
  final double volume;

  const SetVolume(this.volume);
}
