import 'package:sureline/features/notifications_settings/domain/entity/notification_entity.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';

/// Base class for all notification setting states.
abstract class NotificationSettingState {
  const NotificationSettingState();
}

/// Initial state when the notification settings feature is first loaded.
class Initial extends NotificationSettingState {
  const Initial();
}

/// State emitted when notification presets have been successfully retrieved.
/// [result] - List of notification preset entities retrieved from storage
class GotNotificationPresets extends NotificationSettingState {
  final List<NotificationPresetEntity> result;
  GotNotificationPresets(this.result);
}

/// State emitted when a new notification preset has been added and enabled.
/// [id] - The unique identifier of the newly added and enabled preset
class NotificationAddedAndEnabled extends NotificationSettingState {
  final int id;
  const NotificationAddedAndEnabled(this.id);
}

/// State emitted when notification presets have been refreshed from storage.
/// [result] - Updated list of notification preset entities
/// [editAfterwards] - Whether to open edit mode after refresh
/// [id] - Optional specific preset ID to focus on after refresh
class RefreshedNotificationPresets extends NotificationSettingState {
  final bool editAfterwards;
  final int? id;
  final List<NotificationPresetEntity> result;
  const RefreshedNotificationPresets(this.result, {this.editAfterwards = false, this.id});
}
