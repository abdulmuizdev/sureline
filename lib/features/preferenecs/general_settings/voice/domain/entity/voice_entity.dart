class VoiceEntity {
  final String name;
  final String locale;
  final String quality;
  final String gender;
  final String identifier;

  const VoiceEntity({
    required this.name,
    required this.locale,
    required this.gender,
    required this.identifier,
    required this.quality,
  });
}
