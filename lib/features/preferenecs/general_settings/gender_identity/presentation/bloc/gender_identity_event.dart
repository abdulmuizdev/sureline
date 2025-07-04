import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/domain/gender_identity_entity.dart';

abstract class GenderIdentityEvent {
  const GenderIdentityEvent();
}

class GetGenderIdentities extends GenderIdentityEvent {
  const GetGenderIdentities();
}

class OnGenderIdentityPressed extends GenderIdentityEvent {
  List<GenderIdentityEntity> genderIdentities;
  OnGenderIdentityPressed(this.genderIdentities);
}