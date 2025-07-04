abstract class StreakEvent {
  const StreakEvent();
}

class GetStreakStatus extends StreakEvent {
  const GetStreakStatus();
}

class UpdateStreakStatus extends StreakEvent {
  final bool isEnabled;
  UpdateStreakStatus(this.isEnabled);
}