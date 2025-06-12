import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_entity.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';
import 'package:sureline/features/notifications_settings/domain/repository/notification_setting_repository.dart';

class EditNotificationPresetUseCase {
  final NotificationSettingRepository repository;

  EditNotificationPresetUseCase(this.repository);

  Future<Either<Failure, void>> execute(
    NotificationPresetEntity entity
  ) {
    return repository.editNotificationPreset(entity);
  }
}
