import 'package:flutter/material.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/notifications_settings/data/model/day_model.dart';
import 'package:sureline/features/notifications_settings/domain/entity/day_entity.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';

class NotificationPresetModel extends NotificationPresetEntity {
  final List<DayModel> days;

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

  factory NotificationPresetModel.fromJson(Map<String, dynamic> json) {
    return NotificationPresetModel(
      id: json['id'],
      title: json['title'],
      qtyPerDay: json['qtyPerDay'],
      startTime: Utils.stringToTime(json['startTime']),
      endTime: Utils.stringToTime(json['endTime']),
      lastScheduledAt:
          json['lastScheduledAt'] != null
              ? DateTime.parse(json['lastScheduledAt'])
              : null,
      days:
          (json['days'] as List<dynamic>)
              .map((day) => DayModel.fromJson(day))
              .toList(),
      isSelected: json['isSelected'],
      isWritingReminder: json['isWritingReminder'],
      isPracticeReminder: json['isPracticeReminder'],
      isStreakReminder: json['isStreakReminder'],
      isQuoteReminder: json['isQuoteReminder'],
    );
  }

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
      days:
          days?.map((entity) => DayModel.fromEntity(entity)).toList() ??
          this.days,
      isSelected: isSelected ?? this.isSelected,
      isWritingReminder: isWritingReminder ?? this.isWritingReminder,
      isPracticeReminder: isPracticeReminder ?? this.isPracticeReminder,
      isStreakReminder: isStreakReminder ?? this.isStreakReminder,
      isQuoteReminder: isQuoteReminder ?? this.isQuoteReminder,
    );
  }
}
