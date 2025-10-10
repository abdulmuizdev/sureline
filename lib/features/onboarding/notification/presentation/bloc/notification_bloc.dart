import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';
import 'package:sureline/common/domain/use_cases/notifications_settings/edit_notification_preset_use_case.dart';
import 'package:sureline/common/domain/use_cases/notifications_settings/get_notification_presets_use_case.dart';
import 'package:sureline/features/onboarding/notification/presentation/bloc/notification_event.dart';
import 'package:sureline/features/onboarding/notification/presentation/bloc/notification_state.dart';

/// Bloc for managing notification permission requests during onboarding.
/// This bloc handles the initialization of notification permission status,
/// requesting permissions from users, and managing the onboarding flow
/// based on user responses to permission requests.
///
/// The bloc coordinates between the UI and the native permission system,
/// providing proper state management for notification permission operations
/// during the onboarding process.
class OnboardingNotificationBloc
    extends Bloc<OnboardingNotificationEvent, OnboardingNotificationState> {
  final GetNotificationPresetsUseCase _getNotificationPresetsUseCase;
  final EditNotificationPresetUseCase _editNotificationPresetUseCase;

  /// Initializes the bloc with the required dependencies.
  /// Sets up event handlers for all notification permission operations.
  OnboardingNotificationBloc(
    this._getNotificationPresetsUseCase,
    this._editNotificationPresetUseCase,
  ) : super(const NotificationInitial()) {
    _setupEventHandlers();
  }

  /// Sets up event handlers for all notification permission events.
  /// Configures handlers for initialization, permission requests, and user responses.
  void _setupEventHandlers() {
    on<GetGeneralNotificationPreset>(_handleGetGeneralNotificationPreset);
    on<EditGeneralNotificationPreset>(_handleEditGeneralNotificationPreset);
  }

  /// Handles the InitializeNotificationPermission event.
  /// Checks current notification permission status and initializes the system.
  ///
  /// [event] - The InitializeNotificationPermission event
  /// [emit] - Function to emit new states
  void _handleGetGeneralNotificationPreset(
    GetGeneralNotificationPreset event,
    Emitter<OnboardingNotificationState> emit,
  ) async {
    emit(const GettingGeneralNotificationPreset());

    try {
      final presets = await _getNotificationPresetsUseCase.execute();
      presets.fold((failure) => emit(GeneralNotificationPresetFailure(message: failure.message)), (
        presets,
      ) {
        emit(
          GotGeneralNotificationPreset(
            preset: presets.firstWhere((preset) => preset.title == 'General'),
          ),
        );
      });
    } catch (e) {
      emit(
        GeneralNotificationPresetFailure(
          message: 'Failed to get general notification preset: ${e.toString()}',
        ),
      );
    }
  }

  void _handleEditGeneralNotificationPreset(
    EditGeneralNotificationPreset event,
    Emitter<OnboardingNotificationState> emit,
  ) async {
    emit(const EditingGeneralNotificationPreset());

    try {
      final result = await _editNotificationPresetUseCase.execute(event.entity);
      result.fold(
        (failure) => emit(EditingGeneralNotificationPresetFailure(message: failure.message)),
        (success) => emit(EditedGeneralNotificationPreset()),
      );
    } catch (e) {
      emit(EditingGeneralNotificationPresetFailure(message: e.toString()));
    }
  }
}
