import 'package:sureline/features/notifications_settings/domain/entity/day_entity.dart';

/// Data model for day configuration in the data layer.
/// This model extends DayEntity and provides JSON serialization
/// capabilities for storing and retrieving day preferences from local storage.
///
/// The model handles conversion between domain entities and JSON data,
/// ensuring proper data persistence for day selection in notification schedules.
class DayModel extends DayEntity {
  /// Creates a DayModel instance with the specified day configuration.
  ///
  /// [title] - The display name of the day (e.g., "Monday", "Tuesday")
  /// [dateTime] - The internal date representation for the day of the week
  /// [isSelected] - Whether this day is selected for notification delivery
  const DayModel({required super.title, required super.dateTime, required super.isSelected});

  /// Creates a DayModel from a domain DayEntity.
  /// This factory method converts domain entities to data models for persistence.
  ///
  /// [entity] - The domain entity to convert to a data model
  factory DayModel.fromEntity(DayEntity entity) {
    return DayModel(title: entity.title, dateTime: entity.dateTime, isSelected: entity.isSelected);
  }

  /// Creates a DayModel from JSON data retrieved from storage.
  /// This factory method handles deserialization of day configuration
  /// from persistent storage format.
  ///
  /// [json] - JSON data containing day configuration
  factory DayModel.fromJson(Map<String, dynamic> json) {
    return DayModel(
      title: json['title'] as String,
      dateTime: json['dateTime'] as int,
      isSelected: json['isSelected'] as bool,
    );
  }

  /// Converts the DayModel to JSON for storage.
  /// This method serializes the day configuration for persistence.
  ///
  /// Returns a JSON map containing the day configuration data
  Map<String, dynamic> toJson() {
    return {'title': title, 'dateTime': dateTime, 'isSelected': isSelected};
  }
}
