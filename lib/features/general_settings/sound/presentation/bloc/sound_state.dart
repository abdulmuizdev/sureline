abstract class SoundState {
  const SoundState();
}

class Initial extends SoundState {
  const Initial();
}

class GotVolume extends SoundState{
  final double volume;
  const GotVolume(this.volume);
}

class SetVolumeCompleted extends SoundState{
  const SetVolumeCompleted();
}