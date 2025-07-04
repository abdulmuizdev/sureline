abstract class SoundEvent{
  const SoundEvent();
}

class GetVolume extends SoundEvent {
  const GetVolume();
}

class SetVolume extends SoundEvent {
  final double volume;
  const SetVolume(this.volume);
}