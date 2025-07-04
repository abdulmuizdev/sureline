// import 'dart:convert';

// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sureline/core/constants/sp.dart';
// import 'package:sureline/core/constants/sureline_notification_presets.dart';
// import 'package:sureline/core/error/failures.dart';
// import 'package:sureline/features/notifications_settings/data/model/notification_model.dart';
// import 'package:sureline/features/notifications_settings/data/model/notification_preset_model.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// abstract class NotificationSettingsDataSource {
//   Future<Either<Failure, void>> changeNotificationSchedule(
//     NotificationModel model,
//     List<String> quotes,
//   );

//   Future<Either<Failure, void>> scheduleNotification(
//     int id,
//     String title,
//     String body,
//     DateTime at,
//   );

//   Future<Either<Failure, void>> cancelScheduledNotification(int id);

//   Future<Either<Failure, void>> cancelNotificationPreset(int id);

//   Future<Either<Failure, void>> scheduleUpToSixtyNotifications(
//     List<String> quotes,
//   );

//   Either<Failure, NotificationModel?> getNotificationsUserPreferences();

//   Either<Failure, List<NotificationPresetModel>> getNotificationPresets();

//   Future<Either<Failure, NotificationModel>> addNotificationPreset();
// }

// class NotificationSettingsDataSourceImpl
//     extends NotificationSettingsDataSource {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   final SharedPreferences prefs;

//   NotificationSettingsDataSourceImpl(this.prefs);

//   Future<void> initializeNotifications() async {
//     const DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings();

//     const InitializationSettings initializationSettings =
//         InitializationSettings(iOS: initializationSettingsIOS);

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   @override
//   Future<Either<Failure, void>> scheduleUpToSixtyNotifications(
//     List<String> quotes,
//   ) async {
//     await setupTimezone();
//     await initializeNotifications();
//     final userPrefs = prefs.getString(SP.notificationUserPrefs);
//     if (userPrefs == null) {
//       return Right(unit);
//     }
//     final NotificationModel notificationUserPrefs = NotificationModel.fromJson(
//       jsonDecode(userPrefs),
//     );

//     DateTime? lastScheduledAt = _getLastScheduledNotification();
//     if (lastScheduledAt == null) {
//       return Right(unit);
//     }

//     final pendingNotifications =
//         (await flutterLocalNotificationsPlugin.pendingNotificationRequests())
//             .length;

//     if (pendingNotifications < 60) {
//       int limit = 60 - pendingNotifications;
//       final weekDays =
//           notificationUserPrefs.days
//               .where((day) => day.isSelected == true)
//               .toList()
//               .map((day) => day.dateTime)
//               .toList();
//       await scheduleNotifications(
//         qtyPerDay: notificationUserPrefs.qtyPerDay,
//         startTime: notificationUserPrefs.startTime,
//         endTime: notificationUserPrefs.endTime,
//         todayReference: lastScheduledAt,
//         weekdays: weekDays,
//         quotes: quotes,
//         limit: limit,
//       );

//       return Right(unit);
//     } else {
//       debugPrint('no need to schedule more notifications');
//       return Right(unit);
//     }
//   }

//   DateTime? _getLastScheduledNotification() {
//     final lastNotificationAt = prefs.getString(SP.lastNotificationScheduledAt);
//     if (lastNotificationAt == null) {
//       return null;
//     }
//     return DateTime.parse(lastNotificationAt);
//   }

//   @override
//   Future<Either<Failure, void>> cancelScheduledNotification(int id) async {
//     final activeNotifications =
//         await flutterLocalNotificationsPlugin.getActiveNotifications();
//     final streakNotifications =
//         activeNotifications
//             .where((notification) => notification.id == id)
//             .toList();
//     if (streakNotifications.isNotEmpty) {
//       await flutterLocalNotificationsPlugin.cancel(id);
//     }
//     return Right(unit);
//   }

//   @override
//   Future<Either<Failure, void>> cancelNotificationPreset(int id) async {
//     try {
//       final activeNotifications =
//           await flutterLocalNotificationsPlugin.getActiveNotifications();
//       final filteredNotifications =
//           activeNotifications
//               .where(
//                 (notification) =>
//                     notification.id.toString().substring(0, 3) == id.toString(),
//               )
//               .toList();
//       if (filteredNotifications.isNotEmpty) {
//         await flutterLocalNotificationsPlugin.cancel(id);
//       }
//       return Right(unit);
//     } catch (e) {
//       debugPrint('${e}');
//       return Left(UnknownFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, void>> scheduleNotification(
//     int id,
//     String title,
//     String body,
//     DateTime at,
//   ) async {
//     await setupTimezone();
//     await initializeNotifications();
//     final now = tz.TZDateTime.now(tz.local);
//     debugPrint('current minute ${now.minute}');
//     debugPrint('future minute ${at.minute}');
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime(
//         now.location,
//         at.year,
//         at.month,
//         at.day,
//         at.hour,
//         at.minute,
//         at.second,
//       ),
//       NotificationDetails(iOS: DarwinNotificationDetails()),
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       androidScheduleMode: AndroidScheduleMode.exact,
//     );
//     return Right(unit);
//   }

//   @override
//   Future<Either<Failure, void>> changeNotificationSchedule(
//     NotificationModel model,
//     List<String> quotes,
//   ) async {
//     await setupTimezone();
//     await initializeNotifications();

//     await prefs.setString(SP.notificationUserPrefs, jsonEncode(model.toJson()));
//     final weekDays =
//         model.days
//             .where((day) => day.isSelected == true)
//             .toList()
//             .map((day) => day.dateTime)
//             .toList();

//     final scheduledNotifications =
//         (await flutterLocalNotificationsPlugin.pendingNotificationRequests());

//     for (int i = 0; i < scheduledNotifications.length; i++) {
//       await flutterLocalNotificationsPlugin.cancel(
//         scheduledNotifications[i].id,
//       );
//     }

//     int limit = 64;

//     await scheduleNotifications(
//       qtyPerDay: model.qtyPerDay,
//       startTime: model.startTime,
//       endTime: model.endTime,
//       weekdays: weekDays,
//       quotes: quotes,
//       limit: limit,
//       todayReference: DateTime.now(),
//     );
//     return Right(unit);
//   }

//   Future<void> setupTimezone() async {
//     tz.initializeTimeZones();

//     final zone = (await FlutterNativeTimezone.getLocalTimezone());
//     debugPrint(zone);
//     tz.setLocalLocation(tz.getLocation(zone));
//   }

//   Future<void> scheduleNotifications({
//     required int qtyPerDay,
//     DateTime? todayReference,
//     required TimeOfDay startTime,
//     required TimeOfDay endTime,
//     required List<int> weekdays,
//     required List<String> quotes,
//     required int limit,
//   }) async {
//     int notificationsPerDay = qtyPerDay;
//     // _getNotificationsPerDayWithinLimit(
//     //   qtyPerDay,
//     //   weekdays,
//     // );
//     debugPrint('notification per day is $notificationsPerDay');

//     final now = todayReference ?? DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);

//     final start = DateTime(
//       today.year,
//       today.month,
//       today.day,
//       startTime.hour,
//       startTime.minute,
//     );
//     final end = DateTime(
//       today.year,
//       today.month,
//       today.day,
//       endTime.hour,
//       endTime.minute,
//     );
//     final totalSeconds = end.difference(start).inSeconds;
//     debugPrint('total seconds is this $totalSeconds');

//     // notificationsPerDay = _getRateLimitedQty(notificationsPerDay, totalMinutes);

//     if (totalSeconds < 0 || notificationsPerDay <= 0) return;
//     final interval = (totalSeconds / (notificationsPerDay - 1));
//     debugPrint('interval is this ${interval}');
//     debugPrint('interval is this ${interval.round()}');
//     int notificationId = 0;

//     // limit to 60 and log dateTime of last
//     int currentQty = 0;

//     outerLoop:
//     for (final weekday in weekdays) {
//       for (int i = 0; i < notificationsPerDay; i++) {
//         final scheduledTime = start.add(
//           Duration(seconds: interval.round() * i),
//         );
//         final when = _nextInstanceOfWeekdayTime(
//           weekday,
//           scheduledTime.hour,
//           scheduledTime.minute,
//         );
//         await flutterLocalNotificationsPlugin.zonedSchedule(
//           notificationId++,
//           'Sureline',
//           quotes[i],
//           when,
//           const NotificationDetails(iOS: DarwinNotificationDetails()),
//           uiLocalNotificationDateInterpretation:
//               UILocalNotificationDateInterpretation.wallClockTime,
//           androidScheduleMode: AndroidScheduleMode.exact,
//         );
//         currentQty++;
//         if (currentQty >= limit) {
//           await prefs.setString(
//             SP.lastNotificationScheduledAt,
//             when.toIso8601String(),
//           );
//           break outerLoop;
//         }
//       }
//     }
//   }

//   // Future<void> scheduleDailyNotifications({
//   //   required int qtyPerDay,
//   //   required TimeOfDay startTime,
//   //   required TimeOfDay endTime,
//   //   required List<int> weekdays, // Use DateTime.monday, etc.
//   // }) async
//   // {
//   //   int notificationsPerDay = _getNotificationsPerDayWithinLimit(
//   //     qtyPerDay,
//   //     weekdays,
//   //   );
//   //
//   //   final now = DateTime.now();
//   //   final today = DateTime(now.year, now.month, now.day);
//   //
//   //   final start = DateTime(
//   //     today.year,
//   //     today.month,
//   //     today.day,
//   //     startTime.hour,
//   //     startTime.minute,
//   //   );
//   //   final end = DateTime(
//   //     today.year,
//   //     today.month,
//   //     today.day,
//   //     endTime.hour,
//   //     endTime.minute,
//   //   );
//   //   final totalMinutes = end
//   //       .difference(start)
//   //       .inMinutes;
//   //
//   //   notificationsPerDay = _getRateLimitedQty(notificationsPerDay, totalMinutes);
//   //
//   //   if (totalMinutes < 0 || notificationsPerDay <= 0) return;
//   //   debugPrint('check 2');
//   //
//   //   final interval = totalMinutes ~/ (notificationsPerDay - 1);
//   //   debugPrint('check 3');
//   //   int notificationId = 0;
//   //   debugPrint('check 4');
//   //   debugPrint(weekdays);
//   //   debugPrint(weekdays.length);
//   //   for (final weekday in weekdays) {
//   //     debugPrint('check 5');
//   //     for (int i = 0; i < notificationsPerDay; i++) {
//   //       debugPrint('check 6');
//   //       final scheduledTime = start.add(Duration(minutes: interval * i));
//   //       debugPrint('check 7');
//   //       await flutterLocalNotificationsPlugin.zonedSchedule(
//   //         notificationId++,
//   //         'Reminder',
//   //         'This is your scheduled notification.',
//   //         _nextInstanceOfWeekdayTime(
//   //           weekday,
//   //           scheduledTime.hour,
//   //           scheduledTime.minute,
//   //         ),
//   //         const NotificationDetails(iOS: DarwinNotificationDetails()),
//   //         // androidAllowWhileIdle: true,
//   //         uiLocalNotificationDateInterpretation:
//   //         UILocalNotificationDateInterpretation.absoluteTime,
//   //         matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
//   //         androidScheduleMode: AndroidScheduleMode.exact,
//   //       );
//   //       debugPrint('check 2');
//   //     }
//   //   }
//   // }

//   tz.TZDateTime _nextInstanceOfWeekdayTime(int weekday, int hour, int minute) {
//     final now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate = tz.TZDateTime(
//       tz.local,
//       now.year,
//       now.month,
//       now.day,
//       hour,
//       minute,
//     );

//     // Go forward until the next occurrence of that weekday
//     while (scheduledDate.weekday != weekday || scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }

//   int _getNotificationsPerDayWithinLimit(int qtyPerDay, List<int> weekdays) {
//     debugPrint('qty per day $qtyPerDay');
//     int qty = qtyPerDay;
//     int totalNotifications = qty * weekdays.length;

//     while (totalNotifications > 60) {
//       qty--;
//       totalNotifications = qty * weekdays.length;
//     }
//     debugPrint('notifications per day must be $qty');

//     return qty;
//   }

//   int _getRateLimitedQty(int notificationsQty, int totalMinutes) {
//     int qty = notificationsQty;
//     int interval = totalMinutes ~/ (qty - 1);

//     while (interval < 1) {
//       qty--;
//       interval = totalMinutes ~/ (qty - 1);
//     }

//     return qty;
//   }

//   @override
//   Either<Failure, NotificationModel?> getNotificationsUserPreferences() {
//     final userPrefs = prefs.getString(SP.notificationUserPrefs);
//     if (userPrefs == null) {
//       return Right(null);
//     }
//     final NotificationModel notificationUserPrefs = NotificationModel.fromJson(
//       jsonDecode(userPrefs),
//     );
//     return Right(notificationUserPrefs);
//   }

//   @override
//   Future<Either<Failure, NotificationModel>> addNotificationPreset() {
//     // TODO: implement addNotificationPreset
//     throw UnimplementedError();
//   }

//   @override
//   Either<Failure, List<NotificationPresetModel>> getNotificationPresets() {
//     final raw = prefs.getString(SP.notificationPresets);
//     if (raw != null) {
//       List<dynamic> list = jsonDecode(raw);
//       List<NotificationPresetModel> result =
//           list.map((json) => NotificationPresetModel.fromJson(json)).toList();
//       return Right(result);
//     } else {
//       return Right(SurelineNotificationPresets.values);
//     }
//   }
// }
