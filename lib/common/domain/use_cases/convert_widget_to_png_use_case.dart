import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/streak/domain/repository/streak_repository.dart';

class ConvertWidgetToPngUseCase {
  final StreakRepository repository;

  ConvertWidgetToPngUseCase(this.repository);

  Future<Either<Failure, String>> execute(
    Widget widget, {
    double? pixelRatio,

    required double screenWidth,
    required double screenHeight,
  }) {
    return repository.convertWidgetToPng(
      widget,
      pixelRatio: pixelRatio,
      screenWidth: screenWidth,
      screenHeight: screenHeight,
    );
  }
}
