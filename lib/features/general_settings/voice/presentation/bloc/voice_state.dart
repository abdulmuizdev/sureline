import 'package:sureline/features/general_settings/voice/domain/entity/voice_entity.dart';

abstract class VoiceState {
  const VoiceState();
}

class Initial extends VoiceState {
  const Initial();
}

class GettingVoices extends VoiceState {
  const GettingVoices();
}

class GotVoices extends VoiceState {
  final List<VoiceEntity> voices;
  final int selectedIndex;
  const GotVoices(this.voices, this.selectedIndex);
}

class VoiceError extends VoiceState {
  final String message;
  const VoiceError(this.message);
}
