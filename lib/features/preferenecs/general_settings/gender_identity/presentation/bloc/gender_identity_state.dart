import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/domain/gender_identity_entity.dart';

/// Abstract base class for all gender identity states.
abstract class GenderIdentityState {
  const GenderIdentityState();
}

/// Initial state when no gender identity data has been loaded.
class Initial extends GenderIdentityState {
  const Initial();
}

/// State when gender identities are being retrieved.
class GettingGenderIdentities extends GenderIdentityState {
  const GettingGenderIdentities();
}

/// State when gender identities have been successfully retrieved.
class GotGenderIdentities extends GenderIdentityState {
  final List<GenderIdentityEntity> result;

  const GotGenderIdentities(this.result);
}

/// State when an error occurs during gender identity operations.
class GenderIdentityError extends GenderIdentityState {
  final String message;

  const GenderIdentityError(this.message);
}
