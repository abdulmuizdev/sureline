import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';

/// Base class for all notification setting events.
abstract class NotificationSettingEvent {
  const NotificationSettingEvent();
}

/// Event to change the active notification schedule.
/// [entity] - The notification preset entity to activate
class ChangeNotificationSchedule extends NotificationSettingEvent {
  final NotificationPresetEntity entity;
  ChangeNotificationSchedule(this.entity);
}

/// Event to retrieve all available notification presets.
class GetNotificationPresets extends NotificationSettingEvent {
  GetNotificationPresets();
}

/// Event to handle checkbox state changes for notification presets.
/// [isChecked] - Whether the preset is now selected
/// [entity] - The notification preset entity that was toggled
class OnCheckChanged extends NotificationSettingEvent {
  final bool isChecked;
  final NotificationPresetEntity entity;
  OnCheckChanged(this.isChecked, this.entity);
}

/// Event to add a new notification preset.
class AddNotificationPreset extends NotificationSettingEvent {
  AddNotificationPreset();
}

/// Event to refresh the list of notification presets.
/// [editAfterwards] - Whether to open edit mode after refresh
/// [id] - Optional specific preset ID to focus on after refresh
class RefreshNotificationPresets extends NotificationSettingEvent {
  final bool editAfterwards;
  final int? id;
  const RefreshNotificationPresets({this.editAfterwards = false, this.id});
}
