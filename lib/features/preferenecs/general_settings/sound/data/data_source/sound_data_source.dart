import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/constants/constants.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/error/failures.dart';

/// Abstract class defining the contract for sound data operations.
abstract class SoundDataSource {
  /// Retrieves the current volume setting.
  Future<Either<Failure, double>> getVolume();

  /// Sets the volume to the specified value.
  Future<Either<Failure, void>> setVolume(double volume);
}

/// Implementation of SoundDataSource that handles sound operations.
class SoundDataSourceImpl implements SoundDataSource {
  /// Creates a new SoundDataSourceImpl instance.
  const SoundDataSourceImpl();

  @override
  Future<Either<Failure, double>> getVolume() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final volume = prefs.getDouble(SP.volume) ?? Constants.defaultVolume;
      return Right(volume);
    } catch (e) {
      debugPrint('$e');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setVolume(double volume) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(SP.volume, volume);
      App.volume = volume;
      return const Right(null);
    } catch (e) {
      debugPrint('$e');
      return Left(UnknownFailure());
    }
  }
}
