import 'package:sureline/features/preferenecs/general_settings/voice/domain/entity/voice_entity.dart';

/// Abstract base class for all voice-related states.
///
/// States represent the different UI states that the voice settings feature
/// can be in, from initial loading to displaying available voices or
/// indicating error conditions.
abstract class VoiceState {
  const VoiceState();
}

/// Initial state when the voice settings feature is first loaded.
///
/// This state is emitted when the VoiceBloc is first created
/// and no voice data has been loaded yet. The UI should show a loading
/// indicator or empty voice list.
class Initial extends VoiceState {
  const Initial();
}

/// State when voices are being retrieved from the TTS engine.
///
/// This state is emitted while the bloc is fetching available voices
/// from the device's text-to-speech engine. The UI should show a
/// loading indicator during this operation.
class GettingVoices extends VoiceState {
  const GettingVoices();
}

/// State when voices have been successfully retrieved.
///
/// This state is emitted after successfully loading all available
/// voices from the TTS engine. The UI should display the list of
/// voices with the currently selected one highlighted.
///
/// [voices] - List of all available voice entities
/// [selectedIndex] - Index of the currently selected voice in the list
class GotVoices extends VoiceState {
  final List<VoiceEntity> voices;
  final int selectedIndex;

  const GotVoices(this.voices, this.selectedIndex);
}

/// State when an error occurs during voice operations.
///
/// This state is emitted when an error occurs while retrieving
/// voices or changing voice settings. The UI should display an
/// appropriate error message to the user.
///
/// [message] - Error message describing what went wrong
class VoiceError extends VoiceState {
  final String message;

  const VoiceError(this.message);
}
