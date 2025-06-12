import 'package:flutter/material.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/notifications_settings/data/model/day_model.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  final List<DayModel> days;

  const NotificationModel({
    required this.days,
    required super.startTime,
    required super.endTime,
    required super.qtyPerDay,
  }) : super(days: days);

  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      days: entity.days.map((entity) => DayModel.fromEntity(entity)).toList(),
      startTime: entity.startTime,
      endTime: entity.endTime,
      qtyPerDay: entity.qtyPerDay,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      days: (json['days'] as List<dynamic>).map((day) => DayModel.fromJson(day)).toList(),
      startTime: Utils.stringToTime(json['startTime']),
      endTime: Utils.stringToTime(json['endTime']),
      qtyPerDay: json['qtyPerDay'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'days': days.map((day) => day.toJson()).toList(),
      'startTime': Utils.timeToString(startTime),
      'endTime': Utils.timeToString(endTime),
      'qtyPerDay': qtyPerDay,
    };
  }
}
