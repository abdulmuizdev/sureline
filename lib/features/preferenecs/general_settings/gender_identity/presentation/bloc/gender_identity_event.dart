import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/domain/gender_identity_entity.dart';

/// Abstract base class for all gender identity events.
abstract class GenderIdentityEvent {
  const GenderIdentityEvent();
}

/// Event to retrieve gender identities.
class GetGenderIdentities extends GenderIdentityEvent {
  const GetGenderIdentities();
}

/// Event triggered when a gender identity is pressed.
class OnGenderIdentityPressed extends GenderIdentityEvent {
  final List<GenderIdentityEntity> genderIdentities;

  const OnGenderIdentityPressed(this.genderIdentities);
}
