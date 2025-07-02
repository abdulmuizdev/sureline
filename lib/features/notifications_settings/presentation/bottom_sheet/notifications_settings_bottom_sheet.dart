import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';
import 'package:sureline/features/notifications_settings/presentation/bloc/notification_setting_bloc.dart';
import 'package:sureline/features/notifications_settings/presentation/bloc/notification_setting_event.dart';
import 'package:sureline/features/notifications_settings/presentation/bloc/notification_setting_state.dart';
import 'package:sureline/features/notifications_settings/presentation/bottom_sheet/notification_detail_bottom_sheet/notification_detail_bottom_sheet.dart';
import 'package:sureline/features/notifications_settings/presentation/bottom_sheet/widgets/reminder_container.dart';

class NotificationsSettingsBottomSheet extends StatefulWidget {
  const NotificationsSettingsBottomSheet({super.key});

  @override
  State<NotificationsSettingsBottomSheet> createState() =>
      _NotificationsSettingsBottomSheetState();
}

class _NotificationsSettingsBottomSheetState
    extends State<NotificationsSettingsBottomSheet> {
  List<NotificationPresetEntity> _presets = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  locator<NotificationSettingBloc>()
                    ..add(GetNotificationPresets()),
        ),
      ],
      child: BlocListener<NotificationSettingBloc, NotificationSettingState>(
        listener: (context, state) async {
          if (state is GotNotificationPresets) {
            _presets = state.result;
          }
          if (state is RefreshedNotificationPresets) {
            _presets = state.result;
            if (state.editAfterwards) {
              final index = _presets.indexWhere(
                (entity) => entity.id == state.id,
              );
              if (index >= 0) {
                await _showNotificationDetails(_presets[index]);
                if (!context.mounted) return;
                context.read<NotificationSettingBloc>().add(
                  RefreshNotificationPresets(),
                );
              } else {
                debugPrint('index cannot be less than 0');
              }
            }
          }
          if (state is NotificationAddedAndEnabled) {
            context.read<NotificationSettingBloc>().add(
              RefreshNotificationPresets(editAfterwards: true, id: state.id),
            );
          }
        },
        child: BlocBuilder<NotificationSettingBloc, NotificationSettingState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(left: 18, right: 18),
              decoration: Utils.bottomSheetDecoration(ignoreCorners: true),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Set up your daily notifications to make your quotes fit your routine',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _presets.length,
                      itemBuilder: (context, index) {
                        return ReminderContainer(
                          title: _presets[index].title,
                          subTitle:
                              '${_presets[index].qtyPerDay}x ${Utils.getNotificationPresetSubtitle(_presets[index].days)}',
                          timeString:
                              (_presets[index].startTime ==
                                      _presets[index].endTime)
                                  ? Utils.formatTimeOfDay(
                                    _presets[index].startTime,
                                  )
                                  : '${Utils.formatTimeOfDay(_presets[index].startTime)} - ${Utils.formatTimeOfDay(_presets[index].endTime)}',
                          isSelected: _presets[index].isSelected,
                          onPressed: () async {
                            await _showNotificationDetails(_presets[index]);
                            context.read<NotificationSettingBloc>().add(
                              RefreshNotificationPresets(),
                            );
                          },
                          onCheckChanged: (value) {
                            context.read<NotificationSettingBloc>().add(
                              OnCheckChanged(value, _presets[index]),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  SurelineButton(
                    text: 'Add reminder',
                    onPressed: () {
                      context.read<NotificationSettingBloc>().add(
                        AddNotificationPreset(),
                      );
                    },
                    disableVerticalPadding: true,
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showNotificationDetails(NotificationPresetEntity entity) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) => NotificationDetailBottomSheet(presetEntity: entity),
    );
  }
}
