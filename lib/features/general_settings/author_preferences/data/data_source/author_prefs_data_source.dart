import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/core/constants/constants.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/constants/sureline_author_prefs.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/author_preferences/data/model/author_pref_model.dart';

abstract class AuthorPrefsDataSource {
  Future<Either<Failure, void>> updateAuthorPrefs(
    List<AuthorPrefModel> authorPrefs,
  );

  Either<Failure, List<AuthorPrefModel>> getAuthorPrefs();
}

class AuthorPrefsDataSourceImpl extends AuthorPrefsDataSource {
  final SharedPreferences prefs;

  AuthorPrefsDataSourceImpl(this.prefs);

  @override
  Either<Failure, List<AuthorPrefModel>> getAuthorPrefs() {
    try {
      final raw = prefs.getString(SP.authorPreferences);
      List<AuthorPrefModel> authorPrefs =
          (raw != null)
              ? (jsonDecode(raw) as List<dynamic>)
                  .map((json) => AuthorPrefModel.fromJson(json))
                  .toList()
              : SurelineAuthorPrefs.values;

      return Right(authorPrefs);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateAuthorPrefs(
    List<AuthorPrefModel> authorPrefs,
  ) async {
    await prefs.setString(
      SP.authorPreferences,
      jsonEncode(authorPrefs.map((authorPref) => authorPref.toJson()).toList()),
    );

    return Right(unit);
  }
}
