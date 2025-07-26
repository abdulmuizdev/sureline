import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/notifications_settings/domain/repository/notification_setting_repository.dart';

/// Use case for canceling a notification preset.
///
/// This use case handles the business logic for canceling
/// scheduled notification presets.
class CancelNotificationPresetUseCase {
  /// The notification settings repository dependency.
  final NotificationSettingRepository repository;

  /// Creates an instance of [CancelNotificationPresetUseCase].
  const CancelNotificationPresetUseCase(this.repository);

  /// Executes the use case to cancel a notification preset.
  ///
  /// Returns [Either<Failure, void>] indicating success or failure.
  Future<Either<Failure, void>> execute(int id) {
    return repository.cancelNotificationPreset(id);
  }
}
