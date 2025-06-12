import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/entity/quote_entity.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_entity.dart';
import 'package:sureline/features/notifications_settings/domain/repository/notification_setting_repository.dart';

class ScheduleUpToSixtyNotificationsUseCase {
  final NotificationSettingRepository repository;

  ScheduleUpToSixtyNotificationsUseCase(this.repository);

  Future<Either<Failure, void>> execute() {
    return repository.scheduleUpToSixtyNotifications();
  }
}
