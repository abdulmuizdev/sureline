import 'package:sureline/common/domain/entities/streak_display_entity.dart';

/// Data model for streak display visualization with UI state management.
///
/// This model extends StreakDisplayEntity to provide UI-specific data for streak
/// visualization, including check-in status, missed days, gift indicators, and
/// day labels. It supports copyWith operations for immutable state updates.
///
/// Key Features:
/// - UI state tracking (checked, missed, gift days)
/// - Day label management for calendar display
/// - Immutable data with copyWith support
/// - Visual state indicators
/// - Calendar integration support
///
/// Display States:
/// - isChecked: User engaged on this day
/// - isMissed: User missed engagement on this day
/// - isGift: Special reward day indicator
/// - dayLabel: Human-readable day identifier
///
/// UI Integration:
/// - Calendar widget visualization
/// - Streak progress indicators
/// - Visual feedback for user actions
/// - State management for animations
///
/// Data Flow:
/// - Domain entity conversion
/// - UI state propagation
/// - Visual feedback generation
/// - Animation state management
///
/// Usage Patterns:
/// - Calendar day representation
/// - Streak visualization
/// - User engagement tracking
/// - Visual feedback display
class StreakDisplayModel extends StreakDisplayEntity {
  /// Creates a StreakDisplayModel with all required display properties.
  ///
  /// [timeStamp] - The date this display entry represents
  /// [isMissed] - Whether the user missed engagement on this day
  /// [isChecked] - Whether the user engaged on this day
  /// [isGift] - Whether this day has a special reward
  /// [dayLabel] - Human-readable label for the day
  StreakDisplayModel({
    required super.timeStamp,
    required super.isMissed,
    required super.isChecked,
    required super.isGift,
    required super.dayLabel,
  });

  /// Creates a copy of this model with optional parameter updates.
  /// Provides immutable state updates for UI state management.
  ///
  /// [timeStamp] - Optional new timestamp
  /// [isMissed] - Optional new missed state
  /// [isChecked] - Optional new checked state
  /// [isGift] - Optional new gift state
  /// [dayLabel] - Optional new day label
  /// Returns StreakDisplayModel - New instance with updated values
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
