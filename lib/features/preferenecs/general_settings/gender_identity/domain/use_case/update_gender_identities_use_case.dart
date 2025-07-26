import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/domain/gender_identity_entity.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/repository/gender_identity_repository.dart';

/// Use case for updating gender identities.
class UpdateGenderIdentitiesUseCase {
  final GenderIdentityRepository repository;

  /// Creates a new UpdateGenderIdentitiesUseCase instance.
  const UpdateGenderIdentitiesUseCase(this.repository);

  /// Executes the use case to update gender identities.
  Future<Either<Failure, void>> execute(List<GenderIdentityEntity> genderIdentities) {
    return repository.updateGenderIdentities(genderIdentities);
  }
}
