
import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/domain/gender_identity_entity.dart';

abstract class GenderIdentityState {
  const GenderIdentityState();
}

class Initial extends GenderIdentityState {
  const Initial();
}

class GettingGenderIdentities extends GenderIdentityState {
  const GettingGenderIdentities();
}

class GotGenderIdentities extends GenderIdentityState {
  final List<GenderIdentityEntity> result;
  const GotGenderIdentities(this.result);
}

class GenderIdentityError extends GenderIdentityState {
  final String message;
  const GenderIdentityError(this.message);
}