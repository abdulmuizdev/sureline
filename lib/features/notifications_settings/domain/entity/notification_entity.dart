import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sureline/features/notifications_settings/domain/entity/day_entity.dart';

class NotificationEntity extends Equatable {
  final List<DayEntity> days;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
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
