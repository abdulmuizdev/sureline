import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sureline/features/notifications_settings/domain/entity/day_entity.dart';

/// Represents a notification schedule configuration in the domain layer.
/// This entity defines when and how often notifications should be delivered
/// to users, including the time range, frequency, and specific days of the week.
///
/// The entity is used to configure notification presets and manage user
/// preferences for quote delivery timing.
class NotificationEntity extends Equatable {
  /// List of days when notifications should be active.
  /// Each day represents a specific day of the week with enabled/disabled status.
  final List<DayEntity> days;

  /// The earliest time when notifications can be sent.
  /// Notifications will not be scheduled before this time.
  final TimeOfDay startTime;

  /// The latest time when notifications can be sent.
  /// Notifications will not be scheduled after this time.
  final TimeOfDay endTime;

  /// The number of notifications to send per day within the time range.
  /// This controls the frequency of quote delivery.
  final int qtyPerDay;

  const NotificationEntity({
    required this.days,
    required this.startTime,
    required this.endTime,
    required this.qtyPerDay,
  });

  @override
  List<Object?> get props => [days, startTime, endTime, qtyPerDay];
}
