import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';

abstract class NotificationSettingEvent {
  const NotificationSettingEvent();
}

class ChangeNotificationSchedule extends NotificationSettingEvent {
  final NotificationPresetEntity entity;
  ChangeNotificationSchedule(this.entity);
}

class GetNotificationPresets extends NotificationSettingEvent {
  GetNotificationPresets();
}

class OnCheckChanged extends NotificationSettingEvent {
  final bool isChecked;
  final NotificationPresetEntity entity;
  OnCheckChanged(this.isChecked, this.entity);
}

class AddNotificationPreset extends NotificationSettingEvent {
  AddNotificationPreset();
}

class RefreshNotificationPresets extends NotificationSettingEvent {
  final bool editAfterwards;
  final int? id;
  const RefreshNotificationPresets({this.editAfterwards = false, this.id});
}
