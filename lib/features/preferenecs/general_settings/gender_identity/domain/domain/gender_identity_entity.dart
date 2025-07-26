import 'package:sureline/features/preferenecs/general_settings/gender_identity/data/model/gender_identity_model.dart';

/// Domain entity representing a gender identity.
class GenderIdentityEntity {
  /// The title of the gender identity.
  final String title;

  /// Whether this gender identity is selected.
  final bool isSelected;

  /// Creates a new GenderIdentityEntity instance.
  const GenderIdentityEntity({required this.title, this.isSelected = false});

  /// Creates a copy of this entity with updated values.
  GenderIdentityEntity copyWith({String? title, bool? isSelected}) {
    return GenderIdentityEntity(
      title: title ?? this.title,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  /// Creates a GenderIdentityEntity from a GenderIdentityModel.
  factory GenderIdentityEntity.fromModel(GenderIdentityModel model) {
    return GenderIdentityEntity(title: model.title, isSelected: model.isSelected);
  }
}
