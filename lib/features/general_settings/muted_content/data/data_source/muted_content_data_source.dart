import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/core/constants/constants.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/constants/sureline_author_prefs.dart';
import 'package:sureline/core/constants/sureline_muted_content.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/muted_content/data/model/muted_content_model.dart';

abstract class MutedContentDataSource {
  Future<Either<Failure, void>> updateMutedContent(
    List<MutedContentModel> mutedContent,
  );

  Either<Failure, List<MutedContentModel>> getMutedContent();
}

class MutedContentDataSourceImpl extends MutedContentDataSource {
  final SharedPreferences prefs;

  MutedContentDataSourceImpl(this.prefs);

  @override
  Either<Failure, List<MutedContentModel>> getMutedContent() {
    try {
      final raw = prefs.getString(SP.mutedContent);
      List<MutedContentModel> mutedContent =
          (raw != null)
              ? (jsonDecode(raw) as List<dynamic>)
                  .map((json) => MutedContentModel.fromJson(json))
                  .toList()
              : SurelineMutedContent.values;

      return Right(mutedContent);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateMutedContent(
    List<MutedContentModel> mutedContent,
  ) async {
    await prefs.setString(
      SP.mutedContent,
      jsonEncode(
        mutedContent.map((mutedContent) => mutedContent.toJson()).toList(),
      ),
    );

    return Right(unit);
  }
}
