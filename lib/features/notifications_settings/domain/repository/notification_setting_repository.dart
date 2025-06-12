import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/notifications_settings/data/model/notification_model.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_entity.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';

abstract class NotificationSettingRepository {
  Future<Either<Failure, void>> editNotificationPreset(
    NotificationPresetEntity newModel,
  );

  Future<Either<Failure, void>> enableNotificationPreset(
    NotificationPresetEntity entity,
  );

  Future<Either<Failure, void>> cancelNotificationPreset(int id);

  Future<Either<Failure, void>> scheduleUpToSixtyNotifications();

  Future<Either<Failure, List<NotificationPresetEntity>>>
  getNotificationPresets();

  Future<Either<Failure, void>> addNotificationPreset(
    NotificationPresetEntity entity,
  );

  Future<Either<Failure, void>> initializeNotificationsPresets();
}
