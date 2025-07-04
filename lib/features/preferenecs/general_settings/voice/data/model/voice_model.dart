import 'package:sureline/features/preferenecs/general_settings/voice/domain/entity/voice_entity.dart';

class VoiceModel extends VoiceEntity {
  VoiceModel({
    required super.name,
    required super.locale,
    required super.gender,
    required super.identifier,
    required super.quality,
  });

  factory VoiceModel.fromEntity(VoiceEntity entity) {
    return VoiceModel(
      name: entity.name,
      locale: entity.locale,
      gender: entity.gender,
      identifier: entity.identifier,
      quality: entity.quality,
    );
  }

  factory VoiceModel.fromJson(Map<Object?, Object?> json) {
    return VoiceModel(
      name: json['name'].toString(),
      locale: json['locale'].toString(),
      gender: json['gender'].toString(),
      identifier: json['identifier'].toString(),
      quality: json['quality'].toString(),
    );
  }

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
