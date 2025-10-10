import 'package:sureline/common/domain/entities/streak_entity.dart';

/// Data model for streak entity with JSON serialization support.
///
/// This model represents a single streak entry with timestamp tracking and provides
/// conversion methods between domain entities and data models. It extends the base
/// StreakEntity to add JSON serialization capabilities for local storage.
///
/// Key Features:
/// - Timestamp-based streak tracking
/// - JSON serialization for persistence
/// - Entity-to-model conversion
/// - Immutable data structure
/// - Type-safe operations
///
/// Data Structure:
/// - timeStamp: DateTime of streak entry
/// - JSON serialization for SharedPreferences storage
/// - Entity conversion for domain layer integration
///
/// Usage Patterns:
/// - Local storage persistence
/// - Domain layer communication
/// - Streak history tracking
/// - Data transformation layer
///
/// Serialization:
/// - toJson(): Converts model to JSON for storage
/// - fromJson(): Creates model from JSON data
/// - fromEntity(): Converts domain entity to model
///
/// Example Usage:
/// ```dart
/// final model = StreakModel(timeStamp: DateTime.now());
/// final json = model.toJson();
/// final restored = StreakModel.fromJson(json);
/// ```
class StreakModel extends StreakEntity {
  /// Creates a StreakModel instance with required timestamp.
  ///
  /// [timeStamp] - The timestamp when the streak entry was recorded
  StreakModel({required super.timeStamp});

  /// Converts the StreakModel to JSON format for storage.
  /// Serializes the timestamp to ISO8601 string format.
  ///
  /// Returns Map<String, dynamic> - JSON representation of the model
  Map<String, dynamic> toJson() {
    return {'timeStamp': timeStamp.toIso8601String()};
  }

  /// Creates a StreakModel from JSON data.
  /// Deserializes the timestamp from ISO8601 string format.
  ///
  /// [json] - JSON data containing timestamp string
  /// Returns StreakModel - Parsed model instance
  /// Throws FormatException if JSON is invalid
  factory StreakModel.fromJson(Map<String, dynamic> json) {
    return StreakModel(timeStamp: DateTime.parse(json['timeStamp'] as String));
  }

  /// Creates a StreakModel from a StreakEntity.
  /// Converts domain entity to data model for persistence.
  ///
  /// [entity] - Domain entity to convert
  /// Returns StreakModel - Converted model instance
  factory StreakModel.fromEntity(StreakEntity entity) {
    return StreakModel(timeStamp: entity.timeStamp);
  }
}
