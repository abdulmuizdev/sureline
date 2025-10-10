import 'package:equatable/equatable.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';

/// Base class for all onboarding notification events.
/// All events that can be dispatched to the OnboardingNotificationBloc
/// must extend this class to ensure type safety.
abstract class OnboardingNotificationEvent extends Equatable {
  const OnboardingNotificationEvent();

  @override
  List<Object?> get props => [];
}

class GetGeneralNotificationPreset extends OnboardingNotificationEvent {}

class EditGeneralNotificationPreset extends OnboardingNotificationEvent {
  final NotificationPresetEntity entity;

  EditGeneralNotificationPreset({required this.entity});
}
