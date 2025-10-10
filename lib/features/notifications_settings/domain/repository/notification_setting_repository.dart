import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/notifications_settings/data/model/notification_model.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_entity.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';

/// Repository interface for managing notification settings and presets.
/// Provides methods to create, update, enable, and manage notification
/// configurations with proper error handling using Either type.
///
/// This repository acts as the single source of truth for all notification
/// preset operations and scheduling logic.
abstract class NotificationSettingRepository {
  /// Updates an existing notification preset with new configuration.
  ///
  /// [newModel] - The updated notification preset entity with new settings
  /// Returns a failure if the preset cannot be updated or saved
  Future<Either<Failure, void>> editNotificationPreset(NotificationPresetEntity newModel);

  /// Enables a notification preset and schedules notifications based on its configuration.
  /// This will disable other presets and set up the notification schedule.
  ///
  /// [entity] - The notification preset to enable and schedule
  /// Returns a failure if scheduling fails or preset cannot be enabled
  Future<Either<Failure, void>> enableNotificationPreset(NotificationPresetEntity entity);

  /// Cancels all scheduled notifications for a specific preset.
  ///
  /// [id] - The unique identifier of the preset to cancel
  /// Returns a failure if cancellation fails
  Future<Either<Failure, void>> cancelNotificationPreset(int id);

  /// Schedules up to 60 notifications based on the current active preset configuration.
  /// This method handles the complex logic of distributing notifications
  /// across selected days and time ranges.
  ///
  /// Returns a failure if scheduling fails or no active preset is found
  Future<Either<Failure, void>> scheduleUpToSixtyNotifications();

  /// Retrieves all available notification presets from storage.
  ///
  /// Returns a list of notification preset entities or a failure if retrieval fails
  Future<Either<Failure, List<NotificationPresetEntity>>> getNotificationPresets();

  /// Adds a new notification preset to storage.
  ///
  /// [entity] - The new notification preset entity to add
  /// Returns a failure if the preset cannot be added
  Future<Either<Failure, void>> addNotificationPreset(NotificationPresetEntity entity);

  /// Initializes default notification presets if none exist.
  /// This method is typically called during app startup to ensure
  /// users have access to predefined notification configurations.
  ///
  /// Returns a failure if initialization fails
  Future<Either<Failure, void>> initializeNotificationsPresets();
}
