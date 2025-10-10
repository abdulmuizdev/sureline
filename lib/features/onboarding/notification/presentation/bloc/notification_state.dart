import 'package:equatable/equatable.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';

/// Base class for all onboarding notification states.
/// All states that can be emitted by the OnboardingNotificationBloc
/// must extend this class to ensure type safety.
abstract class OnboardingNotificationState extends Equatable {
  const OnboardingNotificationState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the notification onboarding feature is first loaded.
/// This state is emitted before any permission checks or operations are performed.
class NotificationInitial extends OnboardingNotificationState {
  const NotificationInitial();
}

class GettingGeneralNotificationPreset extends OnboardingNotificationState {
  const GettingGeneralNotificationPreset();
}

class GotGeneralNotificationPreset extends OnboardingNotificationState {
  const GotGeneralNotificationPreset({required this.preset});

  final NotificationPresetEntity preset;

  @override
  List<Object?> get props => [preset];
}

class GeneralNotificationPresetFailure extends OnboardingNotificationState {
  const GeneralNotificationPresetFailure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class EditingGeneralNotificationPreset extends OnboardingNotificationState {
  const EditingGeneralNotificationPreset();
}

class EditedGeneralNotificationPreset extends OnboardingNotificationState {
  const EditedGeneralNotificationPreset();
}

class EditingGeneralNotificationPresetFailure extends OnboardingNotificationState {
  const EditingGeneralNotificationPresetFailure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
