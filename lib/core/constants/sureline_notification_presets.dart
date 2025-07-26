/// Notification preset constants for the Sureline app.
///
/// This file contains notification preset configurations and settings
/// for the Sureline app. The [SurelineNotificationPresets] class defines
/// predefined notification schedules and reminder configurations.
///
/// Key Features:
/// - Predefined notification schedules
/// - Daily reminder configurations
/// - Writing and practice reminders
/// - Streak reminder settings
/// - General notification presets
///
/// Usage:
/// ```dart
/// // Access notification presets
/// var presets = SurelineNotificationPresets.values;
///
/// // Get all days selected
/// var allDays = SurelineNotificationPresets.allDaysSelected;
///
/// // Find specific preset
/// var writingPreset = presets.firstWhere((p) => p.isWritingReminder);
/// ```

import 'package:flutter/material.dart';
import 'package:sureline/features/notifications_settings/data/model/day_model.dart';
import 'package:sureline/features/notifications_settings/data/model/notification_preset_model.dart';

/// Notification preset configuration class.
///
/// This class defines predefined notification schedules and reminder
/// configurations for the Sureline app. It provides users with
/// ready-to-use notification settings for different purposes.
///
/// Responsibilities:
/// - Define notification preset configurations
/// - Configure daily reminder schedules
/// - Set up writing and practice reminders
/// - Manage streak reminder settings
/// - Provide general notification options
///
/// Preset Types:
/// - Daily writing reminders: For writing practice
/// - Daily practice reminders: For general practice
/// - General notifications: Standard quote notifications
/// - Streak reminders: For maintaining streaks
class SurelineNotificationPresets {
  /// All days of the week selected for notifications.
  ///
  /// Contains day models for all seven days of the week,
  /// all marked as selected for daily notifications.
  ///
  /// Days Included:
  /// - Sunday (S)
  /// - Monday (M)
  /// - Tuesday (T)
  /// - Wednesday (W)
  /// - Thursday (T)
  /// - Friday (F)
  /// - Saturday (S)
  ///
  /// Usage:
  /// ```dart
  /// // Get all selected days
  /// var allDays = SurelineNotificationPresets.allDaysSelected;
  ///
  /// // Check if specific day is selected
  /// var monday = allDays.firstWhere((d) => d.dateTime == DateTime.monday);
  /// ```
  static final allDaysSelected = [
    const DayModel(title: 'S', dateTime: DateTime.sunday, isSelected: true),
    const DayModel(title: 'M', dateTime: DateTime.monday, isSelected: true),
    const DayModel(title: 'T', dateTime: DateTime.tuesday, isSelected: true),
    const DayModel(title: 'W', dateTime: DateTime.wednesday, isSelected: true),
    const DayModel(title: 'T', dateTime: DateTime.thursday, isSelected: true),
    const DayModel(title: 'F', dateTime: DateTime.friday, isSelected: true),
    const DayModel(title: 'S', dateTime: DateTime.saturday, isSelected: true),
  ];

  /// List of predefined notification preset configurations.
  ///
  /// Contains ready-to-use notification schedules for different
  /// purposes and user needs. Each preset includes:
  /// - Unique identifier
  /// - Title and description
  /// - Start and end times
  /// - Selected days
  /// - Quantity per day
  /// - Special reminder types
  ///
  /// Available Presets:
  /// - Daily writing reminders: 10:00 AM daily
  /// - Daily practice reminders: 10:00 AM daily
  /// - General: 9:00 AM to 10:00 PM, 10 notifications per day
  /// - Streak reminder: 12:00 PM daily
  ///
  /// Usage:
  /// ```dart
  /// // Get all notification presets
  /// var presets = SurelineNotificationPresets.values;
  ///
  /// // Find specific preset types
  /// var writingPresets = presets.where((p) => p.isWritingReminder);
  /// var practicePresets = presets.where((p) => p.isPracticeReminder);
  /// var streakPresets = presets.where((p) => p.isStreakReminder);
  ///
  /// // Get selected presets
  /// var selectedPresets = presets.where((p) => p.isSelected);
  /// ```
  static final List<NotificationPresetModel> values = [
    NotificationPresetModel(
      id: 100,
      title: 'Daily writing reminders',
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 10, minute: 0),
      days: allDaysSelected,
      isSelected: false,
      qtyPerDay: 1,
      lastScheduledAt: null,
      isWritingReminder: true,
    ),
    NotificationPresetModel(
      id: 200,
      title: 'Daily practice reminders',
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 10, minute: 0),
      isSelected: false,
      days: allDaysSelected,
      qtyPerDay: 1,
      lastScheduledAt: null,
      isPracticeReminder: true,
    ),
    NotificationPresetModel(
      id: 300,
      title: 'General',
      startTime: const TimeOfDay(hour: 9, minute: 0),
      endTime: const TimeOfDay(hour: 22, minute: 0),
      isSelected: true,
      days: allDaysSelected,
      qtyPerDay: 10,
      lastScheduledAt: null,
    ),
    NotificationPresetModel(
      id: 400,
      title: 'Streak reminder',
      // TODO: get last check in time
      startTime: const TimeOfDay(hour: 12, minute: 0),
      endTime: const TimeOfDay(hour: 12, minute: 0),
      isSelected: true,
      days: allDaysSelected,
      qtyPerDay: 1,
      lastScheduledAt: null,
      isStreakReminder: true,
    ),
  ];
}
