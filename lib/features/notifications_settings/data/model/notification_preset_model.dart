import 'package:flutter/material.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/notifications_settings/data/model/day_model.dart';
import 'package:sureline/features/notifications_settings/domain/entity/day_entity.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';

/// Data model for notification preset configuration in the data layer.
/// This model extends NotificationPresetEntity and provides JSON serialization
/// capabilities for storing and retrieving notification presets from local storage.
///
/// The model handles conversion between domain entities and JSON data,
/// ensuring proper data persistence for complete notification preset configurations
/// including timing, frequency, day preferences, and reminder types.
class NotificationPresetModel extends NotificationPresetEntity {
  /// List of day models representing the days when notifications are active.
  /// Each day model contains the day information and selection status.
  final List<DayModel> days;

  /// Creates a NotificationPresetModel instance with the specified configuration.
  ///
  /// [id] - Unique identifier for the preset configuration
  /// [title] - Display name for the preset (e.g., "Morning Motivation", "Evening Reflection")
  /// [qtyPerDay] - Number of notifications to send per day within the time range
  /// [startTime] - The earliest time when notifications can be sent
  /// [endTime] - The latest time when notifications can be sent
  /// [lastScheduledAt] - Timestamp of when this preset was last scheduled
  /// [days] - List of day models defining when notifications should be sent
  /// [isSelected] - Whether this preset is currently selected and active
  /// [isWritingReminder] - Whether writing reminder notifications are enabled
  /// [isPracticeReminder] - Whether practice reminder notifications are enabled
  /// [isStreakReminder] - Whether streak reminder notifications are enabled
  /// [isQuoteReminder] - Whether quote reminder notifications are enabled
  NotificationPresetModel({
    required super.id,
    required super.title,
    required super.qtyPerDay,
    required super.startTime,
    required super.endTime,
    required super.lastScheduledAt,
    required this.days,
    required super.isSelected,
    super.isWritingReminder,
    super.isPracticeReminder,
    super.isStreakReminder,
    super.isQuoteReminder,
  }) : super(days: days);

  /// Creates a NotificationPresetModel from JSON data retrieved from storage.
  /// This factory method handles deserialization of complete notification preset
  /// configuration from persistent storage format.
  ///
  /// [json] - JSON data containing notification preset configuration
  factory NotificationPresetModel.fromJson(Map<String, dynamic> json) {
    return NotificationPresetModel(
      id: json['id'] as int,
      title: json['title'] as String,
      qtyPerDay: json['qtyPerDay'] as int,
      startTime: Utils.stringToTime(json['startTime'] as String),
      endTime: Utils.stringToTime(json['endTime'] as String),
      lastScheduledAt:
          json['lastScheduledAt'] != null
              ? DateTime.parse(json['lastScheduledAt'] as String)
              : null,
      days:
          (json['days'] as List<dynamic>)
              .map((day) => DayModel.fromJson(day as Map<String, dynamic>))
              .toList(),
      isSelected: json['isSelected'] as bool,
      isWritingReminder: json['isWritingReminder'] as bool?,
      isPracticeReminder: json['isPracticeReminder'] as bool?,
      isStreakReminder: json['isStreakReminder'] as bool?,
      isQuoteReminder: json['isQuoteReminder'] as bool?,
    );
  }

  /// Converts the NotificationPresetModel to JSON for storage.
  /// This method serializes the complete notification preset configuration
  /// for persistence, including all timing, frequency, and reminder settings.
  ///
  /// Returns a JSON map containing the notification preset configuration data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'qtyPerDay': qtyPerDay,
      'startTime': Utils.timeToString(startTime),
      'endTime': Utils.timeToString(endTime),
      'lastScheduledAt': lastScheduledAt?.toIso8601String(),
      'days': days.map((day) => day.toJson()).toList(),
      'isSelected': isSelected,
      'isWritingReminder': isWritingReminder,
      'isPracticeReminder': isPracticeReminder,
      'isStreakReminder': isStreakReminder,
      'isQuoteReminder': isQuoteReminder,
    };
  }

  /// Creates a NotificationPresetModel from a domain NotificationPresetEntity.
  /// This factory method converts domain entities to data models for persistence.
  ///
  /// [entity] - The domain entity to convert to a data model
  factory NotificationPresetModel.fromEntity(NotificationPresetEntity entity) {
    return NotificationPresetModel(
      id: entity.id,
      title: entity.title,
      qtyPerDay: entity.qtyPerDay,
      startTime: entity.startTime,
      endTime: entity.endTime,
      lastScheduledAt: entity.lastScheduledAt,
      days: entity.days.map((entity) => DayModel.fromEntity(entity)).toList(),
      isSelected: entity.isSelected,
      isPracticeReminder: entity.isPracticeReminder,
      isQuoteReminder: entity.isQuoteReminder,
      isStreakReminder: entity.isStreakReminder,
      isWritingReminder: entity.isWritingReminder,
    );
  }

  /// Creates a copy of this NotificationPresetModel with updated values.
  /// Used for immutable state updates in notification preset configuration.
  ///
  /// All parameters are optional and will use current values if not provided.
  @override
  NotificationPresetModel copyWith({
    int? id,
    String? title,
    int? qtyPerDay,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    DateTime? lastScheduledAt,
    List<DayEntity>? days,
    bool? isSelected,
    bool? isWritingReminder,
    bool? isPracticeReminder,
    bool? isStreakReminder,
    bool? isQuoteReminder,
  }) {
    return NotificationPresetModel(
      id: id ?? this.id,
      title: title ?? this.title,
      qtyPerDay: qtyPerDay ?? this.qtyPerDay,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      lastScheduledAt: lastScheduledAt ?? this.lastScheduledAt,
      days: days?.map((entity) => DayModel.fromEntity(entity)).toList() ?? this.days,
      isSelected: isSelected ?? this.isSelected,
      isWritingReminder: isWritingReminder ?? this.isWritingReminder,
      isPracticeReminder: isPracticeReminder ?? this.isPracticeReminder,
      isStreakReminder: isStreakReminder ?? this.isStreakReminder,
      isQuoteReminder: isQuoteReminder ?? this.isQuoteReminder,
    );
  }
}
