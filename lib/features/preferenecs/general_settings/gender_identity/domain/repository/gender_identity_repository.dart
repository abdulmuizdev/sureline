import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/domain/gender_identity_entity.dart';

/// Abstract repository interface for gender identity operations.
abstract class GenderIdentityRepository {
  /// Updates the stored gender identities.
  Future<Either<Failure, void>> updateGenderIdentities(List<GenderIdentityEntity> genderIdentities);

  /// Retrieves the current gender identities.
  Either<Failure, List<GenderIdentityEntity>> getGenderIdentities();
}
