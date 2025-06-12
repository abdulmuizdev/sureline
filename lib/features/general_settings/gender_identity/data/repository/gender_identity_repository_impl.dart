import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/gender_identity/data/data_source/gender_identity_data_source.dart';
import 'package:sureline/features/general_settings/gender_identity/data/model/gender_identity_model.dart';
import 'package:sureline/features/general_settings/gender_identity/domain/domain/gender_identity_entity.dart';
import 'package:sureline/features/general_settings/gender_identity/domain/repository/gender_identity_repository.dart';

class GenderIdentityRepositoryImpl extends GenderIdentityRepository {
  final GenderIdentityDataSource dataSource;

  GenderIdentityRepositoryImpl(this.dataSource);

  @override
  Either<Failure, List<GenderIdentityEntity>> getGenderIdentities() {
    return dataSource.getGenderIdentities();
  }

  @override
  Future<Either<Failure, void>> updateGenderIdentities(
    List<GenderIdentityEntity> genderIdentities,
  ) {
    return dataSource.updateGenderIdentities(
      genderIdentities
          .map((entity) => GenderIdentityModel.fromEntity(entity))
          .toList(),
    );
  }
}
