import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/common/domain/use_cases/quote/get_random_quotes_use_case.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/constants/sureline_notification_presets.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/notifications_settings/data/model/notification_model.dart';
import 'package:sureline/features/notifications_settings/data/model/notification_preset_model.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

abstract class NotificationSettingsDataSource {
  Future<Either<Failure, void>> editNotificationPreset(
    NotificationPresetModel newModel,
  );

  Future<Either<Failure, void>> enableNotificationPreset(
    NotificationPresetModel model,
  );

  Future<Either<Failure, void>> cancelNotificationPreset(int id);

  Future<Either<Failure, void>> scheduleUpToSixtyNotifications();

  Future<Either<Failure, List<NotificationPresetModel>>>
  getNotificationPresets();

  Future<Either<Failure, void>> addNotificationPreset(
    NotificationPresetModel model,
  );

  Future<Either<Failure, void>> initializeNotificationsPresets();
}

class NotificationSettingsDataSourceImpl
    extends NotificationSettingsDataSource {
  final SharedPreferences prefs;
  final GetRandomQuotesUseCase _getRandomQuotesUseCase;

  NotificationSettingsDataSourceImpl(this.prefs, this._getRandomQuotesUseCase);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<Either<Failure, void>> scheduleUpToSixtyNotifications() async {
    await setupTimezone();
    await initializeNotifications();

    final presets = _getNotificationPresets();
    if (presets == null) {
      debugPrint('it cannot be null');
      return Left(UnknownFailure());
    }

    List<NotificationPresetModel> recurringPresets = _getRecurringPresets(
      presets,
    );

    debugPrint('recurring presets: ${recurringPresets.length}');

    final availableSlots =
        64 -
        (await flutterLocalNotificationsPlugin.pendingNotificationRequests())
            .length;

    debugPrint('available slots: $availableSlots');
    debugPrint('check 0');
    if (availableSlots < 0) {
      debugPrint('it cannot be negative');
      return Left(UnknownFailure());
    }
    debugPrint('check 1');

    List<int> limits = [];
    for (int i = 0; i < recurringPresets.length; i++) {
      if (limits.reduce((a, b) => a + b) < availableSlots) {
        final division = (availableSlots / recurringPresets.length);
        if (division == division.truncate()) {
          limits.add(division.truncate());
        } else {
          limits.add(max(1, division.ceil()));
        }
      } else {
        // slots are full
        limits.add(0);
      }
    }
    debugPrint('check 2');
    for (int i = 0; i < recurringPresets.length; i++) {
      final model = recurringPresets[i];
      final weekDays =
          model.days
              .where((day) => day.isSelected == true)
              .toList()
              .map((day) => day.dateTime)
              .toList();
      final quotesResult = await _getRandomQuotesUseCase.execute(limits[i]);
      await quotesResult.fold((left) {}, (right) async {
        await scheduleNotifications(
          qtyPerDay: model.qtyPerDay,
          startTime: model.startTime,
          endTime: model.endTime,
          todayReference: model.lastScheduledAt,
          weekdays: weekDays,
          quotes: right.map((entity) => entity.quote).toList(),
          limit: limits[i],
          baseId: model.id,
        );
      });
    }
    debugPrint('check 3');
    return Right(unit);
  }

  List<NotificationPresetModel> _getRecurringPresets(
    List<NotificationPresetModel> list,
  ) {
    return list
        .where(
          (model) =>
              model.isSelected == true &&
              (model.isPracticeReminder == false ||
                  model.isQuoteReminder == false ||
                  model.isStreakReminder == false ||
                  model.isWritingReminder == false),
        )
        .toList();
  }

  @override
  Future<Either<Failure, void>> cancelNotificationPreset(int id) async {
    try {
      await _cancelNotificationPreset(id);

      List<NotificationPresetModel>? presets = _getNotificationPresets();
      if (presets == null) {
        debugPrint(' it should not be null');
        return Left(UnknownFailure());
      }
      int index = presets.indexWhere((entity) => entity.id == id);
      presets[index] = presets[index].copyWith(isSelected: false);
      await prefs.setString(
        SP.notificationPresets,
        jsonEncode(presets.map((model) => model.toJson()).toList()),
      );
      return Right(unit);
    } catch (e) {
      debugPrint('error in cancel');
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> editNotificationPreset(
    NotificationPresetModel newModel,
  ) async {
    try {
      await setupTimezone();
      await initializeNotifications();
      final List<NotificationPresetModel>? savedNotificationPresets =
          _getNotificationPresets();
      if (savedNotificationPresets == null) {
        debugPrint('it cannot be null');
        return Left(UnknownFailure());
      }

      final foundPresetIndex = savedNotificationPresets.indexWhere(
        (preset) => preset.id == newModel.id,
      );
      await _cancelNotificationPreset(
        savedNotificationPresets[foundPresetIndex].id,
      );
      await _enableNotificationPreset(newModel);

      savedNotificationPresets[foundPresetIndex] = newModel;
      await prefs.setString(
        SP.notificationPresets,
        jsonEncode(
          savedNotificationPresets.map((model) => model.toJson()).toList(),
        ),
      );

      debugPrint('updated successfully');

      return Right(unit);
    } catch (e) {
      debugPrint('error in edit');
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> enableNotificationPreset(
    NotificationPresetModel model,
  ) async {
    try {
      await setupTimezone();
      await initializeNotifications();
      debugPrint('enable notification preset is called');
      await _enableNotificationPreset(model);
      return Right(unit);
    } catch (e) {
      debugPrint('error in enabling');
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  Future<void> _enableNotificationPreset(NotificationPresetModel model) async {
    final weekDays =
        model.days
            .where((day) => day.isSelected == true)
            .toList()
            .map((day) => day.dateTime)
            .toList();

    int limit = await _getAvailableNotificationScheduleLimit();
    final quotesResult = await _getRandomQuotesUseCase.execute(limit);
    await quotesResult.fold((left) {}, (right) async {
      await scheduleNotifications(
        baseId: model.id,
        qtyPerDay: model.qtyPerDay,
        startTime: model.startTime,
        endTime: model.endTime,
        weekdays: weekDays,
        quotes: right.map((entity) => entity.quote).toList(),
        limit: limit,
        todayReference: model.lastScheduledAt,
        isPracticeReminder: model.isPracticeReminder,
        isStreakReminder: model.isStreakReminder,
        isWritingReminder: model.isWritingReminder,
      );
      List<NotificationPresetModel>? presets = _getNotificationPresets();
      if (presets == null) {
        debugPrint(' it should not be null');
        return Left(UnknownFailure());
      }
      int index = presets.indexWhere((entity) => entity.id == model.id);
      presets[index] = model.copyWith(isSelected: true);
      await prefs.setString(
        SP.notificationPresets,
        jsonEncode(presets.map((preset) => preset.toJson()).toList()),
      );
    });
  }

  DateTime? _getLastScheduledNotification() {
    final lastNotificationAt = prefs.getString(SP.lastNotificationScheduledAt);
    if (lastNotificationAt == null) {
      return null;
    }
    return DateTime.parse(lastNotificationAt);
  }

  Future<int> _getAvailableNotificationScheduleLimit() async {
    final slotsUsed =
        (await flutterLocalNotificationsPlugin.pendingNotificationRequests())
            .length;
    int maxLimit = 64;
    debugPrint('remaining slots: ${maxLimit - slotsUsed}');
    return maxLimit - slotsUsed;
  }

  Future<void> initializeNotifications() async {
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> setupTimezone() async {
    tz.initializeTimeZones();

    final zone = (await FlutterNativeTimezone.getLocalTimezone());
    tz.setLocalLocation(tz.getLocation(zone));
  }

  Future<void> _cancelNotificationPreset(int id) async {
    final activeNotifications =
        await flutterLocalNotificationsPlugin.getActiveNotifications();
    final filteredNotifications =
        activeNotifications
            .where(
              (notification) =>
                  notification.id.toString().substring(0, 3) == id.toString(),
            )
            .toList();
    if (filteredNotifications.isNotEmpty) {
      for (ActiveNotification active in filteredNotifications) {
        if (active.id != null) {
          await flutterLocalNotificationsPlugin.cancel(active.id!);
        } else {
          debugPrint('id is null');
        }
      }
    }
  }

  List<NotificationPresetModel>? _getNotificationPresets() {
    final raw = prefs.getString(SP.notificationPresets);
    if (raw == null) return null;
    List<dynamic> list = jsonDecode(raw);
    final presets =
        list.map((json) => NotificationPresetModel.fromJson(json)).toList();
    return presets;
  }

  Future<void> scheduleNotifications({
    required int baseId,
    required int qtyPerDay,
    DateTime? todayReference,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required List<int> weekdays,
    required List<String> quotes,
    required int limit,
    bool? isWritingReminder,
    bool? isPracticeReminder,
    bool? isStreakReminder,
  }) async {
    debugPrint('schedule is called');
    int notificationsPerDay = qtyPerDay;
    final now = todayReference ?? DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final start = DateTime(
      today.year,
      today.month,
      today.day,
      startTime.hour,
      startTime.minute,
    );
    final end = DateTime(
      today.year,
      today.month,
      today.day,
      endTime.hour,
      endTime.minute,
    );
    final totalSeconds = end.difference(start).inSeconds;

    if (totalSeconds < 0 || notificationsPerDay <= 0) return;
    // final interval = (totalSeconds / (notificationsPerDay - 1));
    final interval = (totalSeconds / (notificationsPerDay));
    int currentQty = 0;
    if (startTime == endTime && qtyPerDay == 1 && weekdays.length == 7) {
      final when = _nextInstanceOfWeekdayTime(startTime.hour, startTime.minute);
      debugPrint('when is this $when');
      await flutterLocalNotificationsPlugin.zonedSchedule(
        int.parse('$baseId$currentQty'),
        'Sureline',
        _getNotificationString(
          '',
          isWritingReminder: isWritingReminder,
          isStreakReminder: isStreakReminder,
          isPracticeReminder: isPracticeReminder,
        ),
        when,
        const NotificationDetails(iOS: DarwinNotificationDetails()),
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidScheduleMode: AndroidScheduleMode.exact,
      );
    } else {
      outerLoop:
      for (final weekday in weekdays) {
        for (int i = 0; i < notificationsPerDay; i++) {
          final scheduledTime = start.add(
            Duration(seconds: interval.round() * i),
          );
          final when = _nextInstanceOfWeekdayTime(
            scheduledTime.hour,
            scheduledTime.minute,
            weekday: weekday,
          );
          debugPrint('when is this 2 $when');
          if (currentQty >= limit) {
            if (currentQty != 0) {
              await prefs.setString(
                SP.lastNotificationScheduledAt,
                when.toIso8601String(),
              );
            }
            break outerLoop;
          }
          await flutterLocalNotificationsPlugin.zonedSchedule(
            int.parse('$baseId$currentQty'),
            'Sureline',
            _getNotificationString(
              quotes[i],
              isWritingReminder: isWritingReminder,
              isStreakReminder: isStreakReminder,
              isPracticeReminder: isPracticeReminder,
            ),
            when,
            const NotificationDetails(iOS: DarwinNotificationDetails()),
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.wallClockTime,
            androidScheduleMode: AndroidScheduleMode.exact,
          );
          currentQty++;
        }
      }
    }
  }

  String _getNotificationString(
    String quote, {
    bool? isWritingReminder,
    bool? isPracticeReminder,
    bool? isStreakReminder,
  }) {
    debugPrint('reminder get string is this');
    debugPrint('${isWritingReminder}');
    debugPrint('${isPracticeReminder}');
    debugPrint('${isStreakReminder}');
    if (isWritingReminder ?? false) {
      return 'Reminder to write quote';
    } else if (isPracticeReminder ?? false) {
      return 'Reminder to practice quote';
    } else if (isStreakReminder ?? false) {
      return 'Check in today to keep your streak going';
    }
    return quote;
  }

  tz.TZDateTime _nextInstanceOfWeekdayTime(
    int hour,
    int minute, {
    int? weekday,
  }) {
    final now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (weekday != null) {
      // Go forward until the next occurrence of that weekday
      while (scheduledDate.weekday != weekday || scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }
    }

    return scheduledDate;
  }

  int _getNotificationsPerDayWithinLimit(int qtyPerDay, List<int> weekdays) {
    debugPrint('qty per day $qtyPerDay');
    int qty = qtyPerDay;
    int totalNotifications = qty * weekdays.length;

    while (totalNotifications > 60) {
      qty--;
      totalNotifications = qty * weekdays.length;
    }
    debugPrint('notifications per day must be $qty');

    return qty;
  }

  int _getRateLimitedQty(int notificationsQty, int totalMinutes) {
    int qty = notificationsQty;
    int interval = totalMinutes ~/ (qty - 1);
    while (interval < 1) {
      qty--;
      interval = totalMinutes ~/ (qty - 1);
    }

    return qty;
  }

  @override
  Future<Either<Failure, void>> addNotificationPreset(
    NotificationPresetModel model,
  ) async {
    try {
      final presets = await getNotificationPresets();
      return await presets.fold((failure) => Left(UnknownFailure()), (
        existingPresets,
      ) async {
        final updatedPresets = [...existingPresets, model];
        await prefs.setString(
          SP.notificationPresets,
          jsonEncode(updatedPresets.map((p) => p.toJson()).toList()),
        );
        return Right(unit);
      });
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<NotificationPresetModel>>>
  getNotificationPresets() async {
    final raw = prefs.getString(SP.notificationPresets);
    if (raw != null) {
      List<dynamic> list = jsonDecode(raw);
      List<NotificationPresetModel> result =
          list.map((json) => NotificationPresetModel.fromJson(json)).toList();
      return Right(result);
    } else {
      debugPrint('saving presets first time: ');
      await prefs.setString(
        SP.notificationPresets,
        jsonEncode(
          SurelineNotificationPresets.values
              .map((model) => model.toJson())
              .toList(),
        ),
      );
      final raw2 = prefs.getString(SP.notificationPresets);
      if (raw2 == null) {
        debugPrint('it should not be null');
        return Left(UnknownFailure());
      }
      List<dynamic> list = jsonDecode(raw2);
      List<NotificationPresetModel> result =
          list.map((json) => NotificationPresetModel.fromJson(json)).toList();
      return Right(result);
    }
  }

  @override
  Future<Either<Failure, void>> initializeNotificationsPresets() async {
    List<NotificationPresetModel>? presets = _getNotificationPresets();
    final scheduledNotifications =
        (await flutterLocalNotificationsPlugin.pendingNotificationRequests())
            .length;
    if (presets == null && scheduledNotifications == 0) {
      final result = await getNotificationPresets();
      await result.fold((left) {}, (right) async {
        for (NotificationPresetModel model in right) {
          if (model.isSelected == true) {
            await enableNotificationPreset(model);
          }
        }
      });
    }
    return Right(unit);
  }
}
