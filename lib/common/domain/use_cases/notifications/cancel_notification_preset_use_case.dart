import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/notifications_settings/domain/repository/notification_setting_repository.dart';

class CancelNotificationPresetUseCase {
  final NotificationSettingRepository repository;

  CancelNotificationPresetUseCase(this.repository);

  Future<Either<Failure, void>> execute(int id) {
    return repository.cancelNotificationPreset(id);
  }
}
