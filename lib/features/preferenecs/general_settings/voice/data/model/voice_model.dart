import 'package:sureline/features/preferenecs/general_settings/voice/domain/entity/voice_entity.dart';

/// Data model representing a voice with JSON serialization capabilities.
///
/// This model extends the VoiceEntity domain entity and adds JSON
/// serialization/deserialization capabilities for data persistence
/// and API communication. It follows the Clean Architecture pattern
/// by providing a clean data layer representation of voice entities.
///
/// The model includes methods for converting between domain entities
/// and JSON representations, enabling seamless data flow between
/// the domain and data layers.
class VoiceModel extends VoiceEntity {
  /// Creates a new VoiceModel instance.
  ///
  /// [name] - The name of the voice
  /// [locale] - The locale of the voice (e.g., 'en-US', 'en-GB')
  /// [gender] - The gender of the voice ('male' or 'female')
  /// [identifier] - The unique identifier of the voice
  /// [quality] - The quality of the voice (e.g., 'enhanced', 'standard')
  const VoiceModel({
    required super.name,
    required super.locale,
    required super.gender,
    required super.identifier,
    required super.quality,
  });

  /// Creates a VoiceModel from a VoiceEntity.
  ///
  /// This factory method converts a domain entity to a data model,
  /// enabling seamless conversion between layers in the Clean Architecture.
  ///
  /// [entity] - The voice entity to convert
  ///
  /// Returns a new VoiceModel instance with the same properties as the entity
  factory VoiceModel.fromEntity(VoiceEntity entity) {
    return VoiceModel(
      name: entity.name,
      locale: entity.locale,
      gender: entity.gender,
      identifier: entity.identifier,
      quality: entity.quality,
    );
  }

  /// Creates a VoiceModel from a JSON map.
  ///
  /// This factory method deserializes a JSON map into a VoiceModel,
  /// typically used when loading voice data from storage or API responses.
  ///
  /// [json] - The JSON map containing voice data
  ///
  /// Returns a new VoiceModel instance with data from the JSON map
  factory VoiceModel.fromJson(Map<String, dynamic> json) {
    return VoiceModel(
      name: json['name']?.toString() ?? '',
      locale: json['locale']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      identifier: json['identifier']?.toString() ?? '',
      quality: json['quality']?.toString() ?? '',
    );
  }

  /// Converts the VoiceModel to a JSON map.
  ///
  /// This method serializes the VoiceModel to a JSON map for
  /// storage or API communication. All values are converted to strings
  /// for consistent serialization.
  ///
  /// Returns a Map<String, String> containing the voice data
  Map<String, String> toJson() {
    return {
      'name': name,
      'locale': locale,
      'gender': gender,
      'identifier': identifier,
      'quality': quality,
    };
  }
}
