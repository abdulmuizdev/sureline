import 'package:sureline/common/domain/entities/streak_entity.dart';

class StreakModel extends StreakEntity {
  StreakModel({required super.timeStamp});

  Map<String, dynamic> toJson() {
    return {'timeStamp': timeStamp.toIso8601String()};
  }

  factory StreakModel.fromJson(Map<String, dynamic> json) {
    return StreakModel(timeStamp: DateTime.parse(json['timeStamp']));
  }

  factory StreakModel.fromEntity(StreakEntity entity) {
    return StreakModel(timeStamp: entity.timeStamp);
  }
}
