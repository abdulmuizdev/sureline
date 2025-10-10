import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preference_app_group/shared_preference_app_group.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/constants/sureline_themes.dart';
import 'package:sureline/core/constants/sureline_themes_mixes.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/data/model/theme_model.dart';

/// Abstract interface for theme data source operations.
///
/// This interface defines the contract for theme data operations including
/// theme retrieval, theme mixes, theme changes, and theme application.
/// It provides a clean abstraction for theme data management.
abstract class ThemeDataSource {
  /// Retrieves all available themes from storage.
  /// Returns Either<Failure, List<ThemeModel>> - Success with themes or failure
  Future<Either<Failure, List<ThemeModel>>> getThemes();

  /// Retrieves theme mixes (curated combinations) from storage.
  /// Returns Either<Failure, List<ThemeModel>> - Success with theme mixes or failure
  Future<Either<Failure, List<ThemeModel>>> getThemesMixes();

  /// Changes the current theme and persists the selection.
  /// Returns Either<Failure, void> - Success or failure of theme change
  Future<Either<Failure, void>> changeTheme(ThemeModel model);

  /// Applies the stored theme to the app.
  /// Returns Either<Failure, void> - Success or failure of theme application
  Future<Either<Failure, void>> setTheme();
}

/// Implementation of ThemeDataSource with SharedPreferences and app group support.
///
/// This class provides comprehensive theme data management including local storage,
/// theme initialization, theme changes, and app group synchronization for widgets.
/// It handles theme persistence, global theme application, and widget theme sharing.
///
/// Key Features:
/// - SharedPreferences-based theme storage
/// - App group synchronization for widgets
/// - Theme initialization and validation
/// - Global theme application
/// - Widget theme sharing
/// - Performance-optimized operations
///
/// Data Management:
/// - Local theme persistence
/// - Theme state synchronization
/// - App group data sharing
/// - Theme validation and initialization
/// - Error handling and recovery
///
/// Widget Integration:
/// - App group theme sharing
/// - Widget background synchronization
/// - Text color sharing
/// - Real-time theme updates
/// - Cross-process communication
///
/// Theme Operations:
/// - Theme collection management
/// - Active theme tracking
/// - Theme change persistence
/// - Global theme application
/// - Theme mix support
class ThemeDataSourceImpl extends ThemeDataSource {
  /// SharedPreferences instance for theme persistence.
  final SharedPreferences prefs;

  /// Creates ThemeDataSourceImpl with SharedPreferences dependency.
  ///
  /// [prefs] - SharedPreferences instance for data persistence
  ThemeDataSourceImpl(this.prefs);

  /// Retrieves themes from SharedPreferences with initialization logic.
  /// Handles theme validation, initialization, and active theme management.
  ///
  /// Returns Either<Failure, List<ThemeModel>> - Success with themes or failure
  @override
  Future<Either<Failure, List<ThemeModel>>> getThemes() async {
    List<ThemeModel> spThemes = _getThemesFromSP();

    List<ThemeEntity> spEntities = spThemes.map((model) => ThemeEntity.fromModel(model)).toList();

    spEntities = spEntities.where((entity) => entity.isUserCreated == false).toList();

    bool isSame = true;

    for (int i = 0; i < spEntities.length; i++) {
      if (spEntities[i] != SurelineThemes.values[i]) {
        isSame = false;
        break;
      } else {
        isSame = true;
      }
    }

    if (spThemes.isEmpty || !isSame) {
      String? activeId = spThemes.where((model) => model.isActive == true).firstOrNull?.id;

      debugPrint('Initializing themes');
      await _initializeThemesInSP();
      spThemes = _getThemesFromSP();

      if (activeId != null) {
        spThemes = spThemes.map((model) => model.copyWith(isActive: model.id == activeId)).toList();
      }
    }

    if (spThemes.isEmpty) {
      debugPrint('Themes not found in sp after initialization');
      return Left(UnknownFailure());
    }

    // Sort themes by DateTime in descending order (newest first)
    spThemes.sort((a, b) => b.lastAccessed.compareTo(a.lastAccessed));

    return Right(spThemes);
  }

  /// Retrieves theme mixes from predefined constants.
  /// Returns curated theme combinations for enhanced user experience.
  ///
  /// Returns Either<Failure, List<ThemeModel>> - Success with theme mixes or failure
  @override
  Future<Either<Failure, List<ThemeModel>>> getThemesMixes() async {
    return Right(
      SurelineThemesMixes.values.map((entity) => ThemeModel.fromEntity(entity)).toList(),
    );
  }

  /// Changes the current theme and persists the selection.
  /// Handles theme activation, persistence, and global application.
  ///
  /// [newModel] - The theme model to activate
  /// Returns Either<Failure, void> - Success or failure of theme change
  @override
  Future<Either<Failure, void>> changeTheme(ThemeModel newModel) async {
    try {
      List<ThemeModel> spThemes = _getThemesFromSP();

      int foundIndex = spThemes.indexWhere((model) {
        return model.id == newModel.id;
      });
      debugPrint('found index is this $foundIndex');

      spThemes = spThemes.map((entity) => entity.copyWith(isActive: false)).toList();
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
        await _setThemeGlobally(newModel);
        return Right(unit);
      } else {
        return Left(UnknownFailure());
      }
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  /// Applies the stored theme to the app on startup.
  /// Handles theme initialization and global application.
  ///
  /// Returns Either<Failure, void> - Success or failure of theme application
  @override
  Future<Either<Failure, void>> setTheme() async {
    try {
      final spThemes = _getThemesFromSP();
      String? activeId = spThemes.where((model) => model.isActive == true).firstOrNull?.id;
      if (activeId == null) {
        await _initializeActiveThemeFromSP();
      }

      final result = _getThemesFromSP();

      String? newActiveId = result.firstWhere((model) => model.isActive == true).id;

      if (newActiveId == null) {
        debugPrint('it sould be greater than 0');
        return Left(UnknownFailure());
      }

      await _setThemeGlobally(result.firstWhere((model) => model.id == newActiveId));
      return Right(unit);
    } catch (e) {
      debugPrint('error in set theme');
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  /// Applies theme globally and synchronizes with app group for widgets.
  /// Updates global app state and shares theme data with widgets.
  ///
  /// [model] - The theme model to apply globally
  Future<void> _setThemeGlobally(ThemeModel model) async {
    App.themeEntity = ThemeEntity.fromModel(model);
    await Utils.saveThemeOnAppGroup();
  }

  /// Writes background asset name to app group for widget synchronization.
  /// Shares background information with iOS widgets.
  ///
  /// [nameWithoutExtension] - Background asset name without file extension
  Future<void> _writeBackgroundAssetToAppGroup(String nameWithoutExtension) async {
    await SharedPreferenceAppGroup.setAppGroup('group.com.abdulmuiz.sureline.quoteWidget');
    await SharedPreferenceAppGroup.setString(SP.imageAssetAppGroup, nameWithoutExtension);
  }

  /// Writes text color to app group for widget synchronization.
  /// Shares text color information with iOS widgets.
  ///
  /// [textColorHex] - Text color in hexadecimal format
  Future<void> _writeTextColorToAppGroup(String textColorHex) async {
    await SharedPreferenceAppGroup.setAppGroup('group.com.abdulmuiz.sureline.quoteWidget');
    await SharedPreferenceAppGroup.setString(SP.textColorAppGroup, textColorHex);
  }

  /// Initializes active theme from SharedPreferences.
  /// Sets the first theme as active if no active theme exists.
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
    await prefs.setString(SP.themes, jsonEncode(spThemes.map((model) => model.toJson()).toList()));
  }

  /// Retrieves themes from SharedPreferences.
  /// Deserializes JSON data to ThemeModel list.
  ///
  /// Returns List<ThemeModel> - List of stored themes
  List<ThemeModel> _getThemesFromSP() {
    final raw = prefs.getString(SP.themes);
    if (raw != null) {
      final list = json.decode(raw) as List<dynamic>;
      return list.map((json) => ThemeModel.fromJson(json as Map<String, dynamic>)).toList();
    }
    return [];
  }

  /// Initializes themes in SharedPreferences from constants.
  /// Sets up default themes for first-time app usage.
  Future<void> _initializeThemesInSP() async {
    final themes =
        SurelineThemes.values.map((entity) => ThemeModel.fromEntity(entity).toJson()).toList();

    debugPrint('themes: ${themes.length}');
    for (int i = 0; i < themes.length; i++) {
      debugPrint('Theme ${i}: ${themes[i]['id']}');
    }

    await prefs.setString(SP.themes, json.encode(themes));
  }
}
