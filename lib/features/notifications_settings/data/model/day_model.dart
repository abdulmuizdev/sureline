import 'package:sureline/features/notifications_settings/domain/entity/day_entity.dart';

class DayModel extends DayEntity {
  const DayModel({
    required super.title,
    required super.dateTime,
    required super.isSelected,
  });

  factory DayModel.fromEntity(DayEntity entity) {
    return DayModel(
      title: entity.title,
      dateTime: entity.dateTime,
      isSelected: entity.isSelected,
    );
  }

  factory DayModel.fromJson(Map<String, dynamic> json) {
    return DayModel(
      title: json['title'],
      dateTime: json['dateTime'],
      isSelected: json['isSelected'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'dateTime': dateTime, 'isSelected': isSelected};
  }
}
