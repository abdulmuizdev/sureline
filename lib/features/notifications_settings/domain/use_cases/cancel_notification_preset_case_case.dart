import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/notifications_settings/domain/repository/notification_setting_repository.dart';

/// Use case for canceling scheduled notifications for a specific preset.
/// This use case encapsulates the business logic for stopping notification
/// delivery for a particular preset configuration.
///
/// When a preset is canceled, all its scheduled notifications are removed
/// from the system scheduler, effectively stopping quote delivery.
class CancelNotificationPresetCaseCase {
  final NotificationSettingRepository repository;
  CancelNotificationPresetCaseCase(this.repository);

  /// Executes the cancel notification preset operation.
  /// This method removes all scheduled notifications for the specified preset
  /// and updates the preset's status to inactive.
  ///
  /// [id] - The unique identifier of the preset to cancel
  /// Returns a failure if cancellation fails or the preset cannot be found
  Future<Either<Failure, void>> execute(int id) {
    return repository.cancelNotificationPreset(id);
  }
}
