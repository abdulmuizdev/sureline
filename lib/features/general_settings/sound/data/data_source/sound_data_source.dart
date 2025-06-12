import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/constants/constants.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/error/failures.dart';

abstract class SoundDataSource {
  Future<Either<Failure, double>> getVolume();
  Future<Either<Failure, void>> setVolume(double volume);
}

class SoundDataSourceImpl extends SoundDataSource {
  SoundDataSourceImpl();

  @override
  Future<Either<Failure, double>> getVolume() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final volume = prefs.getDouble(SP.volume) ?? Constants.defaultVolume;
      return Right(volume);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setVolume(double volume) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(SP.volume, volume);
      App.volume = volume;
      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }
}
