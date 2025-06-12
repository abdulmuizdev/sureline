import 'package:sureline/features/notifications_settings/domain/entity/day_entity.dart';

class SurelineDefaultNotificationDays {
  static const values = [
    DayEntity(title: 'S', dateTime: DateTime.sunday),
    DayEntity(title: 'M', dateTime: DateTime.monday, isSelected: true),
    DayEntity(title: 'T', dateTime: DateTime.tuesday, isSelected: true),
    DayEntity(title: 'W', dateTime: DateTime.wednesday, isSelected: true),
    DayEntity(title: 'T', dateTime: DateTime.thursday, isSelected: true),
    DayEntity(title: 'F', dateTime: DateTime.friday, isSelected: true),
    DayEntity(title: 'S', dateTime: DateTime.saturday, isSelected: true),
  ];
}
