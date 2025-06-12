import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/core/constants/constants.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/constants/sureline_content_prefs.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/content_preferences/data/model/content_pref_model.dart';

abstract class ContentPrefsDataSource {
  Future<Either<Failure, void>> updateContentPrefs(
    List<ContentPrefModel> contentPrefs,
  );

  Either<Failure, List<ContentPrefModel>> getContentPrefs();
}

class ContentPrefsDataSourceImpl extends ContentPrefsDataSource {
  final SharedPreferences prefs;

  ContentPrefsDataSourceImpl(this.prefs);

  @override
  Either<Failure, List<ContentPrefModel>> getContentPrefs() {
    try {
      final raw = prefs.getString(SP.contentPreferences);
      List<ContentPrefModel> contentPrefs =
          (raw != null)
              ? (jsonDecode(raw) as List<dynamic>)
                  .map((json) => ContentPrefModel.fromJson(json))
                  .toList()
              : SurelineContentPrefs.values;

      return Right(contentPrefs);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateContentPrefs(
    List<ContentPrefModel> contentPrefs,
  ) async {
    await prefs.setString(
      SP.contentPreferences,
      jsonEncode(
        contentPrefs.map((contentPref) => contentPref.toJson()).toList(),
      ),
    );

    return Right(unit);
  }
}
