import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sureline/features/notifications_settings/domain/entity/day_entity.dart';

/// Represents a complete notification preset configuration in the domain layer.
/// This entity encapsulates all settings needed to schedule and manage
/// different types of notifications (quotes, writing reminders, practice reminders, etc.)
/// with specific timing, frequency, and day preferences.
///
/// Presets allow users to quickly switch between different notification
/// configurations without manually setting each parameter.
class NotificationPresetEntity extends Equatable {
  /// Unique identifier for the preset configuration.
  final int id;

  /// Display name for the preset (e.g., "Morning Motivation", "Evening Reflection").
  final String title;

  /// Number of notifications to send per day within the time range.
  final int qtyPerDay;

  /// The earliest time when notifications can be sent.
  final TimeOfDay startTime;

  /// The latest time when notifications can be sent.
  final TimeOfDay endTime;

  /// Timestamp of when this preset was last scheduled for notifications.
  /// Used to track scheduling history and avoid duplicate scheduling.
  final DateTime? lastScheduledAt;

  /// Whether this preset is currently selected and active.
  /// Only one preset can be active at a time.
  final bool isSelected;

  /// Whether writing reminder notifications are enabled for this preset.
  final bool? isWritingReminder;

  /// Whether practice reminder notifications are enabled for this preset.
  final bool? isPracticeReminder;

  /// Whether streak reminder notifications are enabled for this preset.
  final bool? isStreakReminder;

  /// Whether quote reminder notifications are enabled for this preset.
  final bool? isQuoteReminder;

  /// List of days when notifications should be active for this preset.
  final List<DayEntity> days;

  NotificationPresetEntity({
    required this.id,
    required this.title,
    required this.qtyPerDay,
    required this.startTime,
    required this.endTime,
    required this.lastScheduledAt,
    this.isWritingReminder,
    this.isPracticeReminder,
    this.isStreakReminder,
    this.isQuoteReminder,
    required this.days,
    required this.isSelected,
  });

  /// Creates a copy of this preset with updated values.
  /// Used for immutable state updates in notification configuration.
  ///
  /// All parameters are optional and will use current values if not provided.
  NotificationPresetEntity copyWith({
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
    return NotificationPresetEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      qtyPerDay: qtyPerDay ?? this.qtyPerDay,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      lastScheduledAt: lastScheduledAt ?? this.lastScheduledAt,
      days: days ?? this.days,
      isSelected: isSelected ?? this.isSelected,
      isWritingReminder: isWritingReminder ?? this.isWritingReminder,
      isPracticeReminder: isPracticeReminder ?? this.isPracticeReminder,
      isStreakReminder: isStreakReminder ?? this.isStreakReminder,
      isQuoteReminder: isQuoteReminder ?? this.isQuoteReminder,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    qtyPerDay,
    startTime,
    endTime,
    lastScheduledAt,
    days,
    isSelected,
    isWritingReminder,
    isPracticeReminder,
    isStreakReminder,
    isQuoteReminder,
  ];
}
