/// Streak display-related domain entities for the Sureline app.
///
/// This file contains the domain entity for handling streak display data
/// within the Sureline app. The [StreakDisplayEntity] represents individual
/// days in a user's streak, including their completion status, timestamps,
/// and special states like missed days or gift days.
///
/// Key Features:
/// - Immutable streak day data structure
/// - Support for checked/unchecked days
/// - Missed day tracking
/// - Gift day identification
/// - Timestamp tracking for completion
/// - Day labeling for UI display
///
/// Usage:
/// ```dart
/// final streakDay = StreakDisplayEntity(
///   timeStamp: DateTime.now(),
///   isMissed: false,
///   isChecked: true,
///   isGift: false,
///   dayLabel: 'Day 1',
/// );
/// ```

/// Entity representing a single day in a user's streak display.
///
/// This entity is used for displaying individual days in a streak calendar
/// or streak tracking interface. It contains information about whether
/// the day was completed, missed, or contains special content like gifts.
///
/// Properties:
/// - [isChecked]: Whether the day has been completed
/// - [dayLabel]: Text label for the day (e.g., "Day 1", "Monday")
/// - [timeStamp]: When the day was completed (null if not completed)
/// - [isMissed]: Whether the day was missed (break in streak)
/// - [isGift]: Whether the day contains a special gift or reward
///
/// The entity is immutable and designed for easy integration with
/// streak display UI components.
class StreakDisplayEntity {
  /// Whether the day has been completed.
  ///
  /// True if the user has completed their daily goal for this day.
  final bool isChecked;

  /// Text label for the day.
  ///
  /// Used for display purposes, such as "Day 1", "Monday", or "Today".
  final String dayLabel;

  /// When the day was completed.
  ///
  /// Contains the timestamp when the user completed their daily goal.
  /// Null if the day has not been completed yet.
  final DateTime? timeStamp;

  /// Whether the day was missed.
  ///
  /// True if the user failed to complete their daily goal on this day,
  /// potentially breaking their streak.
  final bool isMissed;

  /// Whether the day contains a special gift or reward.
  ///
  /// True if this day offers a special reward, bonus content, or gift
  /// for completing the daily goal.
  final bool isGift;

  /// Creates a [StreakDisplayEntity] instance.
  ///
  /// All parameters are required to create a complete streak day representation.
  ///
  /// [timeStamp]: When the day was completed (can be null)
  /// [isMissed]: Whether the day was missed
  /// [isChecked]: Whether the day has been completed
  /// [isGift]: Whether the day contains a special gift
  /// [dayLabel]: Text label for the day
  const StreakDisplayEntity({
    required this.timeStamp,
    required this.isMissed,
    required this.isChecked,
    required this.isGift,
    required this.dayLabel,
  });
}
