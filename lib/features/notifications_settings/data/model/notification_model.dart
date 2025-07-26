import 'package:flutter/material.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/notifications_settings/data/model/day_model.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_entity.dart';

/// Data model for notification configuration in the data layer.
/// This model extends NotificationEntity and provides JSON serialization
/// capabilities for storing and retrieving notification settings from local storage.
///
/// The model handles conversion between domain entities and JSON data,
/// ensuring proper data persistence and retrieval for notification configurations.
class NotificationModel extends NotificationEntity {
  /// List of day models representing the days when notifications are active.
  /// Each day model contains the day information and selection status.
  final List<DayModel> days;

  /// Creates a NotificationModel instance with the specified configuration.
  ///
  /// [days] - List of day models defining when notifications should be sent
  /// [startTime] - The earliest time when notifications can be scheduled
  /// [endTime] - The latest time when notifications can be scheduled
  /// [qtyPerDay] - Number of notifications to send per day within the time range
  const NotificationModel({
    required this.days,
    required super.startTime,
    required super.endTime,
    required super.qtyPerDay,
  }) : super(days: days);

  /// Creates a NotificationModel from a domain NotificationEntity.
  /// This factory method converts domain entities to data models for persistence.
  ///
  /// [entity] - The domain entity to convert to a data model
  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      days: entity.days.map((entity) => DayModel.fromEntity(entity)).toList(),
      startTime: entity.startTime,
      endTime: entity.endTime,
      qtyPerDay: entity.qtyPerDay,
    );
  }

  /// Creates a NotificationModel from JSON data retrieved from storage.
  /// This factory method handles deserialization of notification configuration
  /// from persistent storage format.
  ///
  /// [json] - JSON data containing notification configuration
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      days:
          (json['days'] as List<dynamic>)
              .map((day) => DayModel.fromJson(day as Map<String, dynamic>))
              .toList(),
      startTime: Utils.stringToTime(json['startTime'] as String),
      endTime: Utils.stringToTime(json['endTime'] as String),
      qtyPerDay: json['qtyPerDay'] as int,
    );
  }

  /// Converts the NotificationModel to JSON for storage.
  /// This method serializes the notification configuration for persistence.
  ///
  /// Returns a JSON map containing the notification configuration data
  Map<String, dynamic> toJson() {
    return {
      'days': days.map((day) => day.toJson()).toList(),
      'startTime': Utils.timeToString(startTime),
      'endTime': Utils.timeToString(endTime),
      'qtyPerDay': qtyPerDay,
    };
  }
}
