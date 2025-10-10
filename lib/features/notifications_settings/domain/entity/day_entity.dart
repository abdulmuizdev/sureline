import 'package:equatable/equatable.dart';

/// Represents a single day of the week for notification scheduling.
/// This entity is used to configure which days notifications should be
/// delivered, allowing users to customize their notification schedule.
///
/// Each day contains information about its display name, internal
/// representation, and whether it's selected for notifications.
class DayEntity extends Equatable {
  /// The display name of the day (e.g., "Monday", "Tuesday").
  /// Used for UI presentation and user interaction.
  final String title;

  /// The internal date representation for the day of the week.
  /// Typically corresponds to DateTime.weekday values (1-7).
  final int dateTime;

  /// Whether this day is selected for notification delivery.
  /// Controls whether notifications will be scheduled for this day.
  final bool isSelected;

  const DayEntity({
    required this.title,
    this.isSelected = false,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [title, dateTime, isSelected];

  /// Creates a copy of this entity with updated values.
  /// Used for immutable state updates in notification configuration.
  ///
  /// [title] - Optional new display name for the day
  /// [dateTime] - Optional new internal date representation
  /// [isSelected] - Optional new selection status for notifications
  DayEntity copyWith({String? title, int? dateTime, bool? isSelected}) {
    return DayEntity(
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
