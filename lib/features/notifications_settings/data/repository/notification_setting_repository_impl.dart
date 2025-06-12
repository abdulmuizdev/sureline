import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/notifications_settings/data/data_source/notification_settings_data_source.dart';
import 'package:sureline/features/notifications_settings/data/model/notification_model.dart';
import 'package:sureline/features/notifications_settings/data/model/notification_preset_model.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_entity.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';
import 'package:sureline/features/notifications_settings/domain/repository/notification_setting_repository.dart';

class NotificationSettingRepositoryImpl extends NotificationSettingRepository {
  final NotificationSettingsDataSource dataSource;

  NotificationSettingRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, void>> addNotificationPreset(
    NotificationPresetEntity entity,
  ) {
    return dataSource.addNotificationPreset(
      NotificationPresetModel.fromEntity(entity),
    );
  }

  @override
  Future<Either<Failure, void>> cancelNotificationPreset(int id) {
    return dataSource.cancelNotificationPreset(id);
  }

  @override
  Future<Either<Failure, void>> editNotificationPreset(
    NotificationPresetEntity newEntity,
  ) {
    return dataSource.editNotificationPreset(
      NotificationPresetModel.fromEntity(newEntity),
    );
  }

  @override
  Future<Either<Failure, void>> enableNotificationPreset(
    NotificationPresetEntity entity,
  ) {
    return dataSource.enableNotificationPreset(
      NotificationPresetModel.fromEntity(entity),
    );
  }

  @override
  Future<Either<Failure, List<NotificationPresetEntity>>>
  getNotificationPresets() {
    return dataSource.getNotificationPresets();
  }

  @override
  Future<Either<Failure, void>> scheduleUpToSixtyNotifications() {
    return dataSource.scheduleUpToSixtyNotifications();
  }

  @override
  Future<Either<Failure, void>> initializeNotificationsPresets() {
    return dataSource.initializeNotificationsPresets();
  }
}
