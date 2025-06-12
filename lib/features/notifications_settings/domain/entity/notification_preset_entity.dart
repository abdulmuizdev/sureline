import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sureline/features/notifications_settings/domain/entity/day_entity.dart';

class NotificationPresetEntity extends Equatable {
  final int id;
  final String title;
  final int qtyPerDay;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final DateTime? lastScheduledAt;
  final bool isSelected;
  final bool? isWritingReminder;
  final bool? isPracticeReminder;
  final bool? isStreakReminder;
  final bool? isQuoteReminder;
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
