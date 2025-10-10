import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/domain/gender_identity_entity.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/repository/gender_identity_repository.dart';

/// Use case for retrieving gender identities.
class GetGenderIdentitiesUseCase {
  final GenderIdentityRepository repository;

  /// Creates a new GetGenderIdentitiesUseCase instance.
  const GetGenderIdentitiesUseCase(this.repository);

  /// Executes the use case to retrieve gender identities.
  Either<Failure, List<GenderIdentityEntity>> execute() {
    return repository.getGenderIdentities();
  }
}
