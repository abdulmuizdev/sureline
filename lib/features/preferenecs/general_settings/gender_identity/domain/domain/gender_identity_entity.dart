import 'package:sureline/features/preferenecs/general_settings/gender_identity/data/model/gender_identity_model.dart';

class GenderIdentityEntity {
  final String title;
  final bool isSelected;

  const GenderIdentityEntity({required this.title, this.isSelected = false});

  GenderIdentityEntity copyWith({String? title, bool? isSelected}) {
    return GenderIdentityEntity(
      title: title ?? this.title,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory GenderIdentityEntity.fromModel(GenderIdentityModel model) {
    return GenderIdentityEntity(
      title: model.title,
      isSelected: model.isSelected,
    );
  }
}
