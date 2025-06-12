import 'package:sureline/common/domain/entities/streak_display_entity.dart';

class StreakDisplayModel extends StreakDisplayEntity {
  StreakDisplayModel({
    required super.timeStamp,
    required super.isMissed,
    required super.isChecked,
    required super.isGift,
    required super.dayLabel,
  });

  StreakDisplayModel copyWith({
    DateTime? timeStamp,
    bool? isMissed,
    bool? isChecked,
    bool? isGift,
    String? dayLabel,
  }) {
    return StreakDisplayModel(
      timeStamp: timeStamp ?? this.timeStamp,
      isMissed: isMissed ?? this.isMissed,
      isChecked: isChecked ?? this.isChecked,
      isGift: isGift ?? this.isGift,
      dayLabel: dayLabel ?? this.dayLabel,
    );
  }

}
