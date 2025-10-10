/// Default notification days constants for the Sureline app.
///
/// This file contains default notification day configurations
/// for the Sureline app. The [SurelineDefaultNotificationDays]
/// class defines the default days selected for notifications,
/// excluding Sunday by default.
///
/// Key Features:
/// - Default notification day selections
/// - Weekday-focused notifications
/// - Day entity configurations
/// - Notification scheduling defaults
///
/// Usage:
/// ```dart
/// // Access default notification days
/// var defaultDays = SurelineDefaultNotificationDays.values;
///
/// // Get selected days
/// var selectedDays = defaultDays.where((d) => d.isSelected);
/// ```

import 'package:sureline/features/notifications_settings/domain/entity/day_entity.dart';

/// Default notification days configuration class.
///
/// This class defines the default days selected for notifications
/// in the Sureline app. It provides a sensible default configuration
/// that focuses on weekdays while excluding Sunday.
///
/// Responsibilities:
/// - Define default notification day selections
/// - Configure weekday-focused notifications
/// - Provide sensible notification defaults
/// - Support notification scheduling
///
/// Default Selection:
/// - Sunday: Not selected (default off)
/// - Monday through Saturday: Selected (default on)
class SurelineDefaultNotificationDays {
  /// List of default notification day configurations.
  ///
  /// Contains day entities for all seven days of the week
  /// with default selection states. The default configuration
  /// selects weekdays and Saturday, excluding Sunday.
  ///
  /// Day Configurations:
  /// - Sunday (S): Not selected by default
  /// - Monday (M): Selected by default
  /// - Tuesday (T): Selected by default
  /// - Wednesday (W): Selected by default
  /// - Thursday (T): Selected by default
  /// - Friday (F): Selected by default
  /// - Saturday (S): Selected by default
  ///
  /// Usage:
  /// ```dart
  /// // Get all default notification days
  /// var defaultDays = SurelineDefaultNotificationDays.values;
  ///
  /// // Get only selected days
  /// var selectedDays = defaultDays.where((d) => d.isSelected);
  ///
  /// // Check if specific day is selected
  /// var monday = defaultDays.firstWhere((d) => d.dateTime == DateTime.monday);
  /// var isMondaySelected = monday.isSelected; // true
  /// ```
  static const values = [
    DayEntity(title: 'S', dateTime: DateTime.sunday),
    DayEntity(title: 'M', dateTime: DateTime.monday, isSelected: true),
    DayEntity(title: 'T', dateTime: DateTime.tuesday, isSelected: true),
    DayEntity(title: 'W', dateTime: DateTime.wednesday, isSelected: true),
    DayEntity(title: 'T', dateTime: DateTime.thursday, isSelected: true),
    DayEntity(title: 'F', dateTime: DateTime.friday, isSelected: true),
    DayEntity(title: 'S', dateTime: DateTime.saturday, isSelected: true),
  ];
}
