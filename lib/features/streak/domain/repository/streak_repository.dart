import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sureline/common/domain/entities/streak_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/streak/data/model/streak_model.dart';
import 'package:sureline/common/domain/entities/streak_display_entity.dart';

/// Repository interface for streak management and tracking.
///
/// This repository provides comprehensive streak functionality including logging entries,
/// retrieving streak data, checking streak status, and generating shareable content.
/// It follows the Either pattern for functional error handling and ensures proper
/// separation between domain and data layers.
///
/// Key Features:
/// - Streak entry logging with timestamp tracking
/// - Streak data retrieval and analysis
/// - Streak break detection and validation
/// - Social media content generation
/// - Historical streak data management
///
/// Streak Logic:
/// - Tracks daily user engagement with quotes
/// - Maintains continuous streak counting
/// - Handles streak breaks and resets
/// - Provides streak visualization data
/// - Supports social sharing functionality
///
/// Data Management:
/// - Local storage for streak persistence
/// - Efficient data retrieval and caching
/// - Historical data archiving
/// - Performance-optimized queries
///
/// Social Features:
/// - Shareable streak renderings
/// - PNG image generation for social media
/// - Customizable visual designs
/// - Platform-optimized content
abstract class StreakRepository {
  /// Logs a new streak entry with current timestamp.
  /// Records user engagement and updates streak count.
  ///
  /// Returns Either<Failure, void> - Success or failure of logging operation
  Future<Either<Failure, void>> logStreakEntry();

  /// Clears all streak data and resets streak count.
  /// Removes historical streak entries and resets to zero.
  ///
  /// Returns Either<Failure, void> - Success or failure of data clearing
  Future<Either<Failure, void>> clearStreakData();

  /// Retrieves the most recent streak check-in entry.
  /// Returns the last recorded streak activity for analysis.
  ///
  /// Returns Either<Failure, StreakModel?> - Last check-in or null if none exists
  Either<Failure, StreakModel?> getLastCheckIn();

  /// Retrieves streak data for the last seven days.
  /// Provides daily streak status for visualization and analysis.
  ///
  /// Returns Either<Failure, List<StreakDisplayEntity>> - Seven-day streak data
  Either<Failure, List<StreakDisplayEntity>> getLastSevenDaysStreakData();

  /// Retrieves all historical streak data.
  /// Returns complete streak history for analysis and statistics.
  ///
  /// Returns Either<Failure, List<StreakModel>> - Complete streak history
  Either<Failure, List<StreakModel>> getAllStreakData();

  /// Checks if the streak is broken based on entity list and current date.
  /// Validates streak continuity and determines if streak should reset.
  ///
  /// [entities] - List of streak entities to analyze
  /// [currentDate] - Optional current date for testing (defaults to DateTime.now())
  /// Returns Either<Failure, bool> - True if streak is broken, false if active
  Either<Failure, bool> isStreakBroken(List<StreakEntity> entities, {DateTime? currentDate});

  /// Calculates and returns the total current streak score.
  /// Provides the user's current continuous streak count.
  ///
  /// Returns Either<Failure, int> - Current streak count
  Either<Failure, int> getTotalStreakScore();

  /// Converts a widget to PNG image for social media sharing.
  /// Generates shareable streak content with custom dimensions.
  ///
  /// [widget] - The widget to convert to image
  /// [pixelRatio] - Optional pixel ratio for image quality
  /// [screenWidth] - Required screen width for rendering
  /// [screenHeight] - Required screen height for rendering
  /// Returns Either<Failure, String> - PNG file path or error
  Future<Either<Failure, String>> convertWidgetToPng(
    Widget widget, {
    double? pixelRatio,
    required double screenWidth,
    required double screenHeight,
  });
}
