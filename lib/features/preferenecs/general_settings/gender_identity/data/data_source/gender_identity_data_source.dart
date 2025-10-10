import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/constants/sureline_gender_identities.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/data/model/gender_identity_model.dart';

/// Abstract class defining the contract for gender identity data operations.
abstract class GenderIdentityDataSource {
  /// Updates the stored gender identities.
  Future<Either<Failure, void>> updateGenderIdentities(List<GenderIdentityModel> genderIdentities);

  /// Retrieves the current gender identities.
  Either<Failure, List<GenderIdentityModel>> getGenderIdentities();
}

/// Implementation of GenderIdentityDataSource that handles gender identity operations.
class GenderIdentityDataSourceImpl implements GenderIdentityDataSource {
  final SharedPreferences prefs;

  /// Creates a new GenderIdentityDataSourceImpl instance.
  const GenderIdentityDataSourceImpl(this.prefs);

  @override
  Either<Failure, List<GenderIdentityModel>> getGenderIdentities() {
    try {
      final raw = prefs.getString(SP.genderIdentities);
      final List<GenderIdentityModel> genderIdentity =
          (raw != null)
              ? (jsonDecode(raw) as List<dynamic>)
                  .map((json) => GenderIdentityModel.fromJson(json as Map<String, dynamic>))
                  .toList()
              : SurelineGenderIdentities.values;

      return Right(genderIdentity);
    } catch (e) {
      debugPrint('$e');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateGenderIdentities(
    List<GenderIdentityModel> genderIdentities,
  ) async {
    try {
      await prefs.setString(
        SP.genderIdentities,
        jsonEncode(genderIdentities.map((genderIdentity) => genderIdentity.toJson()).toList()),
      );

      return const Right(null);
    } catch (e) {
      debugPrint('$e');
      return Left(UnknownFailure());
    }
  }
}
