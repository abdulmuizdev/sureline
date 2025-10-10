import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sureline/common/domain/entities/streak_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/streak/data/data_source/streak_data_source.dart';
import 'package:sureline/features/streak/data/model/streak_model.dart';
import 'package:sureline/common/domain/entities/streak_display_entity.dart';
import 'package:sureline/features/streak/domain/repository/streak_repository.dart';

class StreakRepositoryImpl extends StreakRepository {
  final StreakDataSource dataSource;

  StreakRepositoryImpl(this.dataSource);

  @override
  Either<Failure, StreakModel?> getLastCheckIn() {
    return dataSource.getLastCheckIn();
  }

  @override
  Future<Either<Failure, void>> logStreakEntry() {
    return dataSource.logStreakEntry();
  }

  @override
  Either<Failure, List<StreakDisplayEntity>> getLastSevenDaysStreakData() {
    return dataSource.getLastSevenDaysStreakData();
  }

  @override
  Either<Failure, bool> isStreakBroken(
    List<StreakEntity> entities, {
    DateTime? currentDate,
  }) {
    return dataSource.isStreakBroken(
      entities.map((entity) => StreakModel.fromEntity(entity)).toList(),
      currentDate: currentDate,
    );
  }

  @override
  Future<Either<Failure, void>> clearStreakData() {
    return dataSource.clearStreakData();
  }

  @override
  Either<Failure, List<StreakModel>> getAllStreakData() {
    return dataSource.getAllStreakData();
  }

  @override
  Future<Either<Failure, String>> convertWidgetToPng(
    Widget widget, {
    double? pixelRatio,

    required double screenWidth,
    required double screenHeight,
  }) {
    return dataSource.convertWidgetToPng(
      widget,
      pixelRatio: pixelRatio,
      screenHeight: screenHeight,
      screenWidth: screenWidth,
    );
  }

  @override
  Either<Failure, int> getTotalStreakScore() {
    return dataSource.getTotalStreakScore();
  }
}
