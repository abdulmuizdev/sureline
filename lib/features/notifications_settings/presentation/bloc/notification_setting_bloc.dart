import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/constants/sureline_default_notification_days.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/cancel_notification_preset_case_case.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/edit_notification_preset_use_case.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/enable_notification_preset_case_case.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/get_notification_presets_use_case.dart';
import 'package:sureline/features/notifications_settings/presentation/bloc/notification_setting_event.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/add_notification_preset_use_case';
import 'package:sureline/features/notifications_settings/presentation/bloc/notification_setting_state.dart';

class NotificationSettingBloc
    extends Bloc<NotificationSettingEvent, NotificationSettingState> {
  final EditNotificationPresetUseCase _editNotificationPresetUseCase;
  final GetNotificationPresetsUseCase _getNotificationPresetsUseCase;
  final CancelNotificationPresetCaseCase _cancelNotificationPresetCaseCase;
  final EnableNotificationPresetCaseCase _enableNotificationPresetCaseCase;
  final AddNotificationPresetUseCase _addNotificationPresetUseCase;

  NotificationSettingBloc(
    this._editNotificationPresetUseCase,
    this._getNotificationPresetsUseCase,
    this._cancelNotificationPresetCaseCase,
    this._enableNotificationPresetCaseCase,
    this._addNotificationPresetUseCase,
  ) : super(Initial()) {
    on<OnCheckChanged>((event, emit) async {
      if (event.isChecked) {
        await _enableNotificationPresetCaseCase.execute(event.entity);
        add(GetNotificationPresets());
      } else {
        await _cancelNotificationPresetCaseCase.execute(event.entity.id);
        add(GetNotificationPresets());
      }
    });

    on<GetNotificationPresets>((event, emit) async {
      final result = await _getNotificationPresetsUseCase.execute();
      result.fold((left) {}, (right) {
        emit(GotNotificationPresets(right));
      });
    });

    on<ChangeNotificationSchedule>((event, emit) async {
      debugPrint('change notification schedule');
      final result = await _editNotificationPresetUseCase.execute(event.entity);
    });

    on<AddNotificationPreset>((event, emit) async {
      int id = 99999;
      final entity = NotificationPresetEntity(
        id: id,
        title: 'General',
        qtyPerDay: 3,
        startTime: TimeOfDay(hour: 9, minute: 0),
        endTime: TimeOfDay(hour: 17, minute: 0),
        lastScheduledAt: null,
        days: SurelineDefaultNotificationDays.values,
        isSelected: false, // Will enable from use case
      );
      final result = await _addNotificationPresetUseCase.execute(entity);
      await result.fold((left) {}, (right) async {
        final result2 = await _enableNotificationPresetCaseCase.execute(entity);
        result2.fold((left) {}, (right) {
          emit(NotificationAddedAndEnabled(id));
        });
      });
    });

    on<RefreshNotificationPresets>((event, emit) async {
      final result = await _getNotificationPresetsUseCase.execute();
      result.fold((left) {}, (right) {
        emit(
          RefreshedNotificationPresets(
            right,
            editAfterwards: event.editAfterwards,
            id: event.id,
          ),
        );
      });
    });
  }
}
