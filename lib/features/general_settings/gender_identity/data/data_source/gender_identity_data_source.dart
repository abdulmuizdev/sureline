import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/constants/sureline_gender_identities.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/gender_identity/data/model/gender_identity_model.dart';

abstract class GenderIdentityDataSource {
  Future<Either<Failure, void>> updateGenderIdentities(
    List<GenderIdentityModel> genderIdentities,
  );

  Either<Failure, List<GenderIdentityModel>> getGenderIdentities();
}

class GenderIdentityDataSourceImpl extends GenderIdentityDataSource {
  final SharedPreferences prefs;

  GenderIdentityDataSourceImpl(this.prefs);

  @override
  Either<Failure, List<GenderIdentityModel>> getGenderIdentities() {
    try {
      final raw = prefs.getString(SP.genderIdentities);
      List<GenderIdentityModel> genderIdentity =
          (raw != null)
              ? (jsonDecode(raw) as List<dynamic>)
                  .map((json) => GenderIdentityModel.fromJson(json))
                  .toList()
              : SurelineGenderIdentities.values;

      return Right(genderIdentity);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateGenderIdentities(
    List<GenderIdentityModel> genderIdentities,
  ) async {
    await prefs.setString(
      SP.genderIdentities,
      jsonEncode(
        genderIdentities
            .map((genderIdentity) => genderIdentity.toJson())
            .toList(),
      ),
    );

    return Right(unit);
  }
}
