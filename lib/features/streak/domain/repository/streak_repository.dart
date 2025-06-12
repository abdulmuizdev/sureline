import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sureline/common/domain/entities/streak_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/streak/data/model/streak_model.dart';
import 'package:sureline/common/domain/entities/streak_display_entity.dart';

abstract class StreakRepository {
  Future<Either<Failure, void>> logStreakEntry();

  Future<Either<Failure, void>> clearStreakData();

  Either<Failure, StreakModel?> getLastCheckIn();

  Either<Failure, List<StreakDisplayEntity>> getLastSevenDaysStreakData();

  Either<Failure, List<StreakModel>> getAllStreakData();

  Either<Failure, bool> isStreakBroken(
    List<StreakEntity> entities, {
    DateTime? currentDate,
  });
  Either<Failure, int> getTotalStreakScore();
  Future<Either<Failure, String>> convertWidgetToPng(
    Widget widget, {
    double? pixelRatio,

        required double screenWidth,
        required double screenHeight
  });
}
