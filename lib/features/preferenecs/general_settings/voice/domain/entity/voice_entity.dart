/// Domain entity representing a voice with its properties.
class VoiceEntity {
  /// The name of the voice.
  final String name;

  /// The locale of the voice.
  final String locale;

  /// The quality of the voice.
  final String quality;

  /// The gender of the voice.
  final String gender;

  /// The unique identifier of the voice.
  final String identifier;

  /// Creates a new VoiceEntity instance.
  const VoiceEntity({
    required this.name,
    required this.locale,
    required this.gender,
    required this.identifier,
    required this.quality,
  });
}
