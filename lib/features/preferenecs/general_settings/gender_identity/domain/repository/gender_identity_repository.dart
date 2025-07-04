import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/domain/gender_identity_entity.dart';

abstract class GenderIdentityRepository {
  Future<Either<Failure, void>> updateGenderIdentities(
    List<GenderIdentityEntity> genderIdentities,
  );

  Either<Failure, List<GenderIdentityEntity>> getGenderIdentities();
}
