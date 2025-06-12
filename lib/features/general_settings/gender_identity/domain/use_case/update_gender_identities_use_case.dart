import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/gender_identity/domain/domain/gender_identity_entity.dart';
import 'package:sureline/features/general_settings/gender_identity/domain/repository/gender_identity_repository.dart';

class UpdateGenderIdentitiesUseCase {
  final GenderIdentityRepository repository;

  UpdateGenderIdentitiesUseCase(this.repository);

  Future<Either<Failure, void>> execute(List<GenderIdentityEntity> genderIdentities) {
    return repository.updateGenderIdentities(genderIdentities);
  }
}
