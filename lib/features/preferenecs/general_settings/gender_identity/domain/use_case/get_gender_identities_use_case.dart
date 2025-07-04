import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/domain/gender_identity_entity.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/repository/gender_identity_repository.dart';

class GetGenderIdentitiesUseCase {
  final GenderIdentityRepository repository;
  GetGenderIdentitiesUseCase(this.repository);

  Either<Failure, List<GenderIdentityEntity>> execute() {
    return repository.getGenderIdentities();
  }
}