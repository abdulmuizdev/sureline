import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/domain/gender_identity_entity.dart';

/// Data model representing a gender identity with JSON serialization capabilities.
class GenderIdentityModel extends GenderIdentityEntity {
  /// Creates a new GenderIdentityModel instance.
  const GenderIdentityModel({required super.title, super.isSelected});

  /// Converts the GenderIdentityModel to a JSON map.
  Map<String, dynamic> toJson() {
    return {'title': title, 'isSelected': isSelected};
  }

  /// Creates a GenderIdentityModel from a JSON map.
  factory GenderIdentityModel.fromJson(Map<String, dynamic> json) {
    return GenderIdentityModel(
      title: json['title'] as String,
      isSelected: json['isSelected'] as bool? ?? false,
    );
  }

  /// Creates a GenderIdentityModel from a GenderIdentityEntity.
  factory GenderIdentityModel.fromEntity(GenderIdentityEntity entity) {
    return GenderIdentityModel(title: entity.title, isSelected: entity.isSelected);
  }
}
