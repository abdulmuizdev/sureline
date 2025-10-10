import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/notifications_settings/data/model/notification_preset_model.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';
import 'package:sureline/features/notifications_settings/domain/repository/notification_setting_repository.dart';

/// Use case for enabling a notification preset and scheduling its notifications.
/// This use case encapsulates the business logic for activating a notification
/// configuration and setting up the actual notification scheduling.
///
/// When a preset is enabled, it becomes the active configuration and
/// notifications are scheduled according to its settings (time range, days, frequency).
class EnableNotificationPresetCaseCase {
  final NotificationSettingRepository repository;
  EnableNotificationPresetCaseCase(this.repository);

  /// Executes the enable notification preset operation.
  /// This method activates the specified preset and schedules notifications
  /// based on its configuration (time range, selected days, frequency).
  ///
  /// [entity] - The notification preset entity to enable and schedule
  /// Returns a failure if scheduling fails or the preset cannot be enabled
  Future<Either<Failure, void>> execute(NotificationPresetEntity entity) {
    return repository.enableNotificationPreset(entity);
  }
}
