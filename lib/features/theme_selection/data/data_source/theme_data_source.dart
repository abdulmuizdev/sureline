import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/constants/sureline_themes.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/data/model/create_and_edit_theme_model.dart';

abstract class ThemeDataSource {
  Future<Either<Failure, List<ThemeModel>>> getThemes();

  Future<Either<Failure, List<ThemeModel>>> getThemesMixes();

  Future<Either<Failure, void>> changeTheme(ThemeModel model);

  Future<Either<Failure, void>> setTheme();
}

class ThemeDataSourceImpl extends ThemeDataSource {
  final SharedPreferences prefs;
  ThemeDataSourceImpl(this.prefs);

  @override
  Future<Either<Failure, List<ThemeModel>>> getThemes() async {
    List<ThemeModel> spThemes = _getThemesFromSP();

    final spEntities =
        spThemes.map((model) => ThemeEntity.fromModel(model)).toList();

    bool isSame = false;

    for (int i = 0; i < spEntities.length; i++) {
      if (spEntities[i] != SurelineThemes.values[i]) {
        isSame = false;
        break;
      } else {
        isSame = true;
      }
    }

    if (spThemes.isEmpty || !isSame) {
      debugPrint('Initializing themes');
      await _initializeThemesInSP();
      spThemes = _getThemesFromSP();
    }

    if (spThemes.isEmpty) {
      debugPrint('Themes not found in sp after initialization');
      return Left(UnknownFailure());
    }

    // Sort themes by DateTime in descending order (newest first)
    spThemes.sort((a, b) => b.lastAccessed.compareTo(a.lastAccessed));

    return Right(spThemes);
  }

  @override
  Future<Either<Failure, List<ThemeModel>>> getThemesMixes() async {
    return Right(
      SurelineThemes.values
          .map((entity) => ThemeModel.fromEntity(entity))
          .toList(),
    );
  }

  @override
  Future<Either<Failure, void>> changeTheme(ThemeModel newModel) async {
    try {
      List<ThemeModel> spThemes = _getThemesFromSP();

      int foundIndex = spThemes.indexWhere((model) {
        return model.id == newModel.id;
      });
      debugPrint('found index is this $foundIndex');

      spThemes =
          spThemes.map((entity) => entity.copyWith(isActive: false)).toList();
      if (foundIndex < 0) {
        debugPrint('its a new theme (editted or created)');
        spThemes.add(newModel.copyWith(isActive: true));
      } else {
        spThemes[foundIndex] = newModel.copyWith(isActive: true);
      }

      for (int i = 0; i < spThemes.length; i++) {
        debugPrint('Theme ${i}: isActive = ${spThemes[i].isActive}');
      }

      final isSuccessful = await prefs.setString(
        SP.themes,
        jsonEncode(spThemes.map((model) => model.toJson()).toList()),
      );
      debugPrint('isSuccessful: $isSuccessful');
      if (isSuccessful) {
        _setThemeGlobally(newModel);
        return Right(unit);
      } else {
        return Left(UnknownFailure());
      }
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setTheme() async {
    try {
      final spThemes = _getThemesFromSP();
      int activeIndex = spThemes.indexWhere((model) => model.isActive == true);
      if (activeIndex < 0) {
        await _initializeActiveThemeFromSP();
      }

      final result = _getThemesFromSP();

      int newActiveIndex = result.indexWhere((model) => model.isActive == true);

      // Alternative implementation with for loop
      int newActiveIndexForLoop = -1;
      for (int i = 0; i < result.length; i++) {
        if (result[i].isActive == true) {
          newActiveIndexForLoop = i;
          break;
        }
      }
      debugPrint('indexWhere result: $newActiveIndex');
      debugPrint('for loop result: $newActiveIndexForLoop');

      if (newActiveIndex < 0) {
        debugPrint('it sould be greater than 0');
        return Left(UnknownFailure());
      }

      _setThemeGlobally(result[newActiveIndex]);
      return Right(unit);
    } catch (e) {
      debugPrint('error in set theme');
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  void _setThemeGlobally(ThemeModel model) {
    // App.homeActionColor = model.actionButtonColor;
    // App.homeButtonColor = model.buttonColor;

    // App.themeEntity = ThemeEntity(
    //   textDecorEntity: ThemeTextDecorEntity.fromModel(model.textDecorModel),
    //   backgroundEntity: ThemeBackgroundEntity.fromModel(model.backgroundModel),
    //   previewQuote: model.previewQuote,
    //   lastAccessed: DateTime.now(),
    // );
    App.themeEntity = ThemeEntity.fromModel(model);
  }

  Future<void> _initializeActiveThemeFromSP() async {
    debugPrint('Initializing thems');
    List<ThemeModel> spThemes = _getThemesFromSP();
    if (spThemes.isEmpty) {
      debugPrint('its emtpy');
      await _initializeThemesInSP();
    }
    spThemes = _getThemesFromSP();
    spThemes[0] = spThemes[0].copyWith(isActive: true);
    debugPrint('double check ${spThemes[0].isActive}');
    await prefs.setString(
      SP.themes,
      jsonEncode(spThemes.map((model) => model.toJson()).toList()),
    );
  }

  List<ThemeModel> _getThemesFromSP() {
    final raw = prefs.getString(SP.themes);
    if (raw != null) {
      List<dynamic> list = json.decode(raw);
      return list.map((json) => ThemeModel.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> _initializeThemesInSP() async {
    final themes =
        SurelineThemes.values
            .map((entity) => ThemeModel.fromEntity(entity).toJson())
            .toList();

    debugPrint('themes: ${themes.length}');
    for (int i = 0; i < themes.length; i++) {
      debugPrint('Theme ${i}: ${themes[i]['id']}');
    }

    await prefs.setString(SP.themes, json.encode(themes));
  }
}
