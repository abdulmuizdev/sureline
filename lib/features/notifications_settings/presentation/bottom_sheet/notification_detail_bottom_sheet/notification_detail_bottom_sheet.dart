import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/notifications_settings/domain/entity/day_entity.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';
import 'package:sureline/features/notifications_settings/presentation/bloc/notification_setting_bloc.dart';
import 'package:sureline/features/notifications_settings/presentation/bloc/notification_setting_event.dart';
import 'package:sureline/features/notifications_settings/presentation/bloc/notification_setting_state.dart';
import 'package:sureline/features/notifications_settings/presentation/bottom_sheet/notification_detail_bottom_sheet/widgets/notification_detail_normal_selector.dart';
import 'package:sureline/features/notifications_settings/presentation/bottom_sheet/notification_detail_bottom_sheet/widgets/notification_detail_selector.dart';
import 'package:sureline/features/notifications_settings/presentation/bottom_sheet/notification_detail_bottom_sheet/widgets/repeat_selector.dart';
import 'package:sureline/features/notifications_settings/presentation/bottom_sheet/notification_detail_bottom_sheet/widgets/time_selector.dart';

class NotificationDetailBottomSheet extends StatefulWidget {
  final NotificationPresetEntity presetEntity;

  const NotificationDetailBottomSheet({super.key, required this.presetEntity});

  @override
  State<NotificationDetailBottomSheet> createState() =>
      _NotificationDetailBottomSheetState();
}

class _NotificationDetailBottomSheetState
    extends State<NotificationDetailBottomSheet> {
  late List<DayEntity> _days;
  final _now = DateTime.now();
  late DateTime _startTime;
  late DateTime _endTime;

  late int _qtyPerDay;
  late bool _isOneTime;
  bool _showCountSelector = true;

  @override
  void initState() {
    super.initState();
    _days = widget.presetEntity.days;
    // _startTime = DateTime(_now.year, _now.month, _now.day, 9, 0);
    // _endTime = DateTime(_now.year, _now.month, _now.day, 22, 0);
    _startTime = DateTime(
      _now.year,
      _now.month,
      _now.day,
      widget.presetEntity.startTime.hour,
      widget.presetEntity.startTime.minute,
    );
    _endTime = DateTime(
      _now.year,
      _now.month,
      _now.day,
      widget.presetEntity.endTime.hour,
      widget.presetEntity.endTime.minute,
    );
    _qtyPerDay = widget.presetEntity.qtyPerDay;
    _isOneTime = _startTime == _endTime;
    _showCountSelector =
        (widget.presetEntity.isPracticeReminder == false &&
            widget.presetEntity.isStreakReminder == false &&
            widget.presetEntity.isWritingReminder == false);
  }

  void _checkDifference(BuildContext context) {
    // final newEntity = NotificationEntity(
    //   days: _days,
    //   startTime: TimeOfDay.fromDateTime(_startTime),
    //   endTime: TimeOfDay.fromDateTime(_endTime),
    //   qtyPerDay: _qtyPerDay,
    // );
    final newEntity = widget.presetEntity.copyWith(
      qtyPerDay: _qtyPerDay,
      startTime: TimeOfDay.fromDateTime(_startTime),
      endTime: TimeOfDay.fromDateTime(_endTime),
      days: _days,
    );

    if (newEntity != widget.presetEntity) {
      context.read<NotificationSettingBloc>().add(
        ChangeNotificationSchedule(newEntity.copyWith(isSelected: true)),
      );
    } else {
      debugPrint('its same');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<NotificationSettingBloc>()),
      ],
      child: BlocListener<NotificationSettingBloc, NotificationSettingState>(
        listener: (context, state) {},
        child: BlocBuilder<NotificationSettingBloc, NotificationSettingState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                color: AppColors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SurelineBackButton(title: 'Done'),
                    SizedBox(height: 27),
                    Text(
                      widget.presetEntity.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 18),
                    if (!_isOneTime) ...[
                      NotificationDetailNormalSelector(
                        title: 'Type of quote',
                        onPressed: () {},
                        actionTitle: 'General',
                        isFirst: true,
                      ),
                    ],
                    if (_showCountSelector) ...[
                      NotificationDetailSelector(
                        title: 'How many',
                        count: _qtyPerDay,
                        onValueChanged: (val) {
                          setState(() {
                            _qtyPerDay = val;
                          });
                          _checkDifference(context);
                        },
                      ),
                    ],
                    TimeSelector(
                      title: (_isOneTime) ? 'Time' : 'Start at',
                      time: _startTime,
                      onValueChanged: (time) {
                        setState(() {
                          _startTime = time;
                          if (_isOneTime) {
                            _endTime = _startTime;
                          }
                        });
                        _checkDifference(context);
                      },
                    ),
                    if (!_isOneTime) ...[
                      TimeSelector(
                        title: 'End at',
                        time: _endTime,
                        onValueChanged: (time) {
                          setState(() {
                            _endTime = time;
                          });
                          _checkDifference(context);
                        },
                      ),
                    ],
                    if (!_isOneTime) ...[
                      RepeatSelector(
                        days: _days,
                        onSelectionChange: (updatedDays) {
                          setState(() {
                            _days = updatedDays;
                          });
                          HapticFeedback.lightImpact();
                          _checkDifference(context);
                        },
                      ),
                    ],
                    NotificationDetailNormalSelector(
                      title: 'Sound',
                      onPressed: () {},
                      actionTitle: 'Positive',
                      isLast: true,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
