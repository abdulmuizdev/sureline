import 'package:sureline/features/notifications_settings/domain/entity/notification_entity.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';

abstract class NotificationSettingState {
  const NotificationSettingState();
}

class Initial extends NotificationSettingState {
  const Initial();
}

class GotNotificationPresets extends NotificationSettingState {
  final List<NotificationPresetEntity> result;
  GotNotificationPresets(this.result);
}

class NotificationAddedAndEnabled extends NotificationSettingState {
  final int id;
  const NotificationAddedAndEnabled(this.id);
}

class RefreshedNotificationPresets extends NotificationSettingState {
  final bool editAfterwards;
  final int? id;
  final List<NotificationPresetEntity> result;
  const RefreshedNotificationPresets(
    this.result, {
    this.editAfterwards = false,
    this.id,
  });
}
