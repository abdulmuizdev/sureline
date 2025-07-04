import 'package:sureline/features/preferenecs/general_settings/voice/domain/entity/voice_entity.dart';

abstract class VoiceEvent {
  const VoiceEvent();
}

class GetVoices extends VoiceEvent {
  const GetVoices();
}

class OnVoiceItemPressed extends VoiceEvent {
  final VoiceEntity entity;
  const OnVoiceItemPressed(this.entity);
}