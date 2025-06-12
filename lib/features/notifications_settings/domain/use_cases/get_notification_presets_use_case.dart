import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';
import 'package:sureline/features/notifications_settings/domain/repository/notification_setting_repository.dart';

class GetNotificationPresetsUseCase {
  final NotificationSettingRepository repository;
  GetNotificationPresetsUseCase(this.repository);

  Future<Either<Failure, List<NotificationPresetEntity>>> execute() {
    return repository.getNotificationPresets();
  }
}