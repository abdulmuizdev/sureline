class StreakDisplayEntity {
  final bool isChecked;
  final String dayLabel;
  final DateTime? timeStamp;
  final bool isMissed;
  final bool isGift;

  const StreakDisplayEntity({
    required this.timeStamp,
    required this.isMissed,
    required this.isChecked,
    required this.isGift,
    required this.dayLabel,
  });
}
