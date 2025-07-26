import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/data/data_source/gender_identity_data_source.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/data/model/gender_identity_model.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/domain/gender_identity_entity.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/repository/gender_identity_repository.dart';

/// Implementation of GenderIdentityRepository that handles gender identity operations.
class GenderIdentityRepositoryImpl implements GenderIdentityRepository {
  final GenderIdentityDataSource dataSource;

  /// Creates a new GenderIdentityRepositoryImpl instance.
  const GenderIdentityRepositoryImpl(this.dataSource);

  @override
  Either<Failure, List<GenderIdentityEntity>> getGenderIdentities() {
    return dataSource.getGenderIdentities();
  }

  @override
  Future<Either<Failure, void>> updateGenderIdentities(
    List<GenderIdentityEntity> genderIdentities,
  ) {
    return dataSource.updateGenderIdentities(
      genderIdentities.map(GenderIdentityModel.fromEntity).toList(),
    );
  }
}
