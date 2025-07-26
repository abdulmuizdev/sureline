/// Abstract base class for all sound-related states.
///
/// States represent the different UI states that the sound settings feature
/// can be in, from initial loading to displaying volume settings or
/// indicating successful save operations.
abstract class SoundState {
  const SoundState();
}

/// Initial state when the sound settings feature is first loaded.
///
/// This state is emitted when the SoundBloc is first created
/// and no volume data has been loaded yet. The UI should show a loading
/// indicator or default volume slider position.
class Initial extends SoundState {
  const Initial();
}

/// State when the current volume setting has been retrieved.
///
/// This state is emitted after successfully loading the user's
/// saved volume setting from persistent storage. The UI should
/// update the volume slider to reflect the retrieved value.
///
/// [volume] - The retrieved volume value (0.0 to 1.0)
class GotVolume extends SoundState {
  final double volume;

  const GotVolume(this.volume);
}

/// State when the volume setting has been successfully saved.
///
/// This state is emitted after successfully saving the new volume
/// setting to persistent storage. The UI can use this state to
/// show a brief success indicator or update other components
/// that depend on the volume setting.
class SetVolumeCompleted extends SoundState {
  const SetVolumeCompleted();
}
