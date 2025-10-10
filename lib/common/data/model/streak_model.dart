import 'package:sureline/common/domain/entities/streak_entity.dart';

/// Data model for streak entity.
///
/// This class represents a streak entry with its timestamp.
class StreakModel extends StreakEntity {
  /// Creates a StreakModel instance.
  ///
  /// Parameters:
  /// - [timeStamp]: The timestamp of the streak entry
  StreakModel({required super.timeStamp});

  /// Converts the StreakModel to JSON.
  Map<String, dynamic> toJson() {
    return {'timeStamp': timeStamp.toIso8601String()};
  }

  /// Creates a StreakModel from JSON data.
  factory StreakModel.fromJson(Map<String, dynamic> json) {
    return StreakModel(timeStamp: DateTime.parse(json['timeStamp'] as String));
  }

  /// Creates a StreakModel from a StreakEntity.
  factory StreakModel.fromEntity(StreakEntity entity) {
    return StreakModel(timeStamp: entity.timeStamp);
  }
}
