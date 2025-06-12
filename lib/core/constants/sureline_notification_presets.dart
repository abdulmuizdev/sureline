import 'package:flutter/material.dart';
import 'package:sureline/features/notifications_settings/data/model/day_model.dart';
import 'package:sureline/features/notifications_settings/data/model/notification_preset_model.dart';

class SurelineNotificationPresets {
  static final allDaysSelected = [
    DayModel(title: 'S', dateTime: DateTime.sunday, isSelected: true),
    DayModel(title: 'M', dateTime: DateTime.monday, isSelected: true),
    DayModel(title: 'T', dateTime: DateTime.tuesday, isSelected: true),
    DayModel(title: 'W', dateTime: DateTime.wednesday, isSelected: true),
    DayModel(title: 'T', dateTime: DateTime.thursday, isSelected: true),
    DayModel(title: 'F', dateTime: DateTime.friday, isSelected: true),
    DayModel(title: 'S', dateTime: DateTime.saturday, isSelected: true),
  ];
  static final List<NotificationPresetModel> values = [
    NotificationPresetModel(
      id: 100,
      title: 'Daily writing reminders',
      startTime: TimeOfDay(hour: 10, minute: 0),
      endTime: TimeOfDay(hour: 10, minute: 0),
      days: allDaysSelected,
      isSelected: false,
      qtyPerDay: 1,
      lastScheduledAt: null,
      isWritingReminder: true,
    ),
    NotificationPresetModel(
      id: 200,
      title: 'Daily practice reminders',
      startTime: TimeOfDay(hour: 10, minute: 0),
      endTime: TimeOfDay(hour: 10, minute: 0),
      isSelected: false,
      days: allDaysSelected,
      qtyPerDay: 1,
      lastScheduledAt: null,
      isPracticeReminder: true,
    ),
    NotificationPresetModel(
      id: 300,
      title: 'General',
      startTime: TimeOfDay(hour: 9, minute: 0),
      endTime: TimeOfDay(hour: 22, minute: 0),
      isSelected: true,
      days: allDaysSelected,
      qtyPerDay: 10,
      lastScheduledAt: null,
    ),
    NotificationPresetModel(
      id: 400,
      title: 'Streak reminder',
      // TODO: get last check in time
      startTime: TimeOfDay(hour: 12, minute: 0),
      endTime: TimeOfDay(hour: 12, minute: 0),
      isSelected: true,
      days: allDaysSelected,
      qtyPerDay: 1,
      lastScheduledAt: null,
      isStreakReminder: true,
    ),
  ];
}