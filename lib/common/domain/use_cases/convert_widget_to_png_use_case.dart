/// Widget conversion use cases for the Sureline app.
///
/// This file contains the use case for converting Flutter widgets
/// to PNG format within the Sureline app. The [ConvertWidgetToPngUseCase]
/// encapsulates the business logic for widget-to-image conversion
/// for sharing or storage purposes.
///
/// Key Features:
/// - Clean Architecture use case pattern
/// - Dependency injection with repository
/// - Functional error handling with Either
/// - Widget to PNG conversion
/// - Configurable screen dimensions and pixel ratio
///
/// Usage:
/// ```dart
/// final useCase = ConvertWidgetToPngUseCase(streakRepository);
/// final result = await useCase.execute(
///   widget,
///   screenWidth: 375.0,
///   screenHeight: 812.0,
///   pixelRatio: 3.0,
/// );
/// result.fold(
///   (failure) => handleError(failure),
///   (pngData) => handlePngData(pngData),
/// );
/// ```

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/streak/domain/repository/streak_repository.dart';

/// Use case for converting a widget to PNG format.
///
/// This use case handles the business logic for converting Flutter widgets
/// to PNG image format for sharing or storage purposes. It follows the Clean
/// Architecture pattern by encapsulating the business rules and delegating
/// the actual conversion to the repository layer.
///
/// Responsibilities:
/// - Coordinate widget to PNG conversion
/// - Handle conversion parameters (dimensions, pixel ratio)
/// - Coordinate with streak repository
/// - Handle success and failure scenarios
/// - Provide clean interface for presentation layer
///
/// Dependencies:
/// - [StreakRepository]: For widget conversion operations
///
/// Returns: [Either<Failure, String>] containing the PNG data or failure
class ConvertWidgetToPngUseCase {
  /// The streak repository dependency.
  ///
  /// Used to perform widget to PNG conversion operations.
  final StreakRepository repository;

  /// Creates an instance of [ConvertWidgetToPngUseCase].
  ///
  /// [repository]: The streak repository for widget conversion operations
  const ConvertWidgetToPngUseCase(this.repository);

  /// Executes the use case to convert a widget to PNG.
  ///
  /// This method encapsulates the business logic for converting
  /// a Flutter widget to PNG format. It delegates the actual
  /// conversion to the repository and returns a functional result
  /// containing the PNG data or failure.
  ///
  /// [widget]: The Flutter widget to convert to PNG
  /// [screenWidth]: The width of the screen for conversion
  /// [screenHeight]: The height of the screen for conversion
  /// [pixelRatio]: The pixel ratio for conversion (optional)
  /// Returns: [Either<Failure, String>] containing the PNG data or failure
  ///
  /// Example:
  /// ```dart
  /// final result = await useCase.execute(
  ///   MyWidget(),
  ///   screenWidth: 375.0,
  ///   screenHeight: 812.0,
  ///   pixelRatio: 3.0,
  /// );
  /// result.fold(
  ///   (failure) => print('Conversion failed: ${failure.message}'),
  ///   (pngData) => savePngData(pngData),
  /// );
  /// ```
  Future<Either<Failure, String>> execute(
    Widget widget, {
    required double screenWidth,
    required double screenHeight,
    double? pixelRatio,
  }) {
    return repository.convertWidgetToPng(
      widget,
      pixelRatio: pixelRatio,
      screenWidth: screenWidth,
      screenHeight: screenHeight,
    );
  }
}
