import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/notifications_settings/data/model/notification_preset_model.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';
import 'package:sureline/features/notifications_settings/domain/repository/notification_setting_repository.dart';

class EnableNotificationPresetCaseCase {
  final NotificationSettingRepository repository;
  EnableNotificationPresetCaseCase(this.repository);

  Future<Either<Failure, void>> execute(NotificationPresetEntity entity) {
    return repository.enableNotificationPreset(entity);
  }
}