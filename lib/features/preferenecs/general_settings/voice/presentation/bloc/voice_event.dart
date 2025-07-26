import 'package:sureline/features/preferenecs/general_settings/voice/domain/entity/voice_entity.dart';

/// Abstract base class for all voice-related events.
///
/// Events are dispatched to the VoiceBloc to trigger state changes
/// and business logic operations in the voice settings feature.
/// This feature allows users to select and configure text-to-speech
/// voices for reading quotes aloud.
abstract class VoiceEvent {
  const VoiceEvent();
}

/// Event to retrieve all available voices from the TTS engine.
///
/// This event triggers the loading of all available text-to-speech
/// voices from the device's TTS engine. The bloc will emit GotVoices
/// state with the list of available voices and the currently selected one.
class GetVoices extends VoiceEvent {
  const GetVoices();
}

/// Event triggered when a voice item is pressed in the UI.
///
/// This event is dispatched when the user selects a voice from the
/// voice list. The bloc will change the current voice setting and
/// update the TTS engine configuration.
///
/// [entity] - The voice entity that was selected
class OnVoiceItemPressed extends VoiceEvent {
  final VoiceEntity entity;

  const OnVoiceItemPressed(this.entity);
}
