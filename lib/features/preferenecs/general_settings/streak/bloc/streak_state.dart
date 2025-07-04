abstract class StreakState {
  const StreakState();
}

class Initial extends StreakState {}

class GotStreakStatus extends StreakState {
  final bool isEnabled;
  GotStreakStatus(this.isEnabled);
}

class StreakStatusUpdated extends StreakState {
  final bool isEnabled;
  const StreakStatusUpdated(this.isEnabled);
}