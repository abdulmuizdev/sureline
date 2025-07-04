
import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/domain/gender_identity_entity.dart';

class GenderIdentityModel extends GenderIdentityEntity {
  GenderIdentityModel({required super.title, super.isSelected});

  Map<String, dynamic> toJson() {
    return {'title': title, 'isSelected': isSelected};
  }

  factory GenderIdentityModel.fromJson(Map<String, dynamic> json) {
    return GenderIdentityModel(
      title: json['title'],
      isSelected: json['isSelected'],
    );
  }

  factory GenderIdentityModel.fromEntity(GenderIdentityEntity entity) {
    return GenderIdentityModel(title: entity.title, isSelected: entity.isSelected);
  }
}
