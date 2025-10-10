/// Streak-related domain entities for the Sureline app.

/// Entity representing a basic streak entry.
class StreakEntity {
  /// When the streak entry was created or completed.
  final DateTime timeStamp;

  /// Creates a [StreakEntity] instance.
  /// [timeStamp] - When the streak entry was created/completed
  const StreakEntity({required this.timeStamp});
}
