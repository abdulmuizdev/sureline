import 'package:sureline/features/streak/data/model/streak_model.dart';

/// Data model for archived streak entries with analysis metadata.
///
/// This model extends StreakModel to add archival information for future analysis
/// and data mining. It tracks when streak data was archived and provides
/// enhanced serialization for long-term storage and analytics.
///
/// Key Features:
/// - Archival timestamp tracking
/// - Enhanced JSON serialization
/// - Historical data preservation
/// - Analytics metadata support
/// - Long-term storage optimization
///
/// Archival Purpose:
/// - Data analysis and insights
/// - User behavior tracking
/// - Performance optimization
/// - Historical trend analysis
/// - Storage management
///
/// Data Structure:
/// - Inherits all StreakModel properties
/// - archivedOn: DateTime when data was archived
/// - Enhanced JSON format for analytics
///
/// Usage Patterns:
/// - Historical data preservation
/// - Analytics data collection
/// - Storage optimization
/// - User behavior analysis
/// - Performance monitoring
///
/// Analytics Integration:
/// - User engagement patterns
/// - Streak retention analysis
/// - Feature usage tracking
/// - Performance metrics
/// - User journey mapping
class StreakArchiveModel extends StreakModel {
  /// Timestamp when this streak entry was archived.
  /// Used for tracking when data was moved to archival storage.
  final DateTime archivedOn;

  /// Creates a StreakArchiveModel with streak data and archival metadata.
  ///
  /// [timeStamp] - Original streak entry timestamp
  /// [archivedOn] - When this entry was archived
  StreakArchiveModel({required super.timeStamp, required this.archivedOn});

  /// Converts the archived model to JSON with archival metadata.
  /// Includes both original streak data and archival timestamp.
  ///
  /// Returns Map<String, dynamic> - JSON with streak and archival data
  @override
  Map<String, dynamic> toJson() {
    return {'archivedOn': archivedOn.toIso8601String(), 'timeStamp': timeStamp.toIso8601String()};
  }
}
