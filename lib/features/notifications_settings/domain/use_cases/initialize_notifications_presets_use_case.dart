import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/notifications_settings/domain/repository/notification_setting_repository.dart';

/// Use case for initializing default notification presets in the system.
/// This use case is responsible for setting up predefined notification
/// configurations that users can choose from when first using the app.
///
/// The initialization ensures that users have access to sensible default
/// notification schedules without having to create configurations from scratch.
class InitializeNotificationsPresetsUseCase {
  final NotificationSettingRepository repository;

  InitializeNotificationsPresetsUseCase(this.repository);

  /// Executes the initialization of default notification presets.
  /// This method is typically called during app startup to ensure
  /// users have access to predefined notification configurations.
  ///
  /// Returns a failure if initialization fails or presets cannot be created
  Future<Either<Failure, void>> execute() {
    return repository.initializeNotificationsPresets();
  }
}
