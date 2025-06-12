import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/streak/data/model/streak_display_model.dart';
import 'package:sureline/features/streak/data/model/streak_model.dart';

abstract class StreakDataSource {
  Future<Either<Failure, void>> logStreakEntry();

  Either<Failure, StreakModel?> getLastCheckIn();

  Either<Failure, List<StreakModel>> getAllStreakData();

  Either<Failure, bool> isStreakBroken(
    List<StreakModel> streakData, {
    DateTime? currentDate,
  });

  Future<Either<Failure, void>> clearStreakData();

  Either<Failure, List<StreakDisplayModel>> getLastSevenDaysStreakData();

  Future<Either<Failure, String>> convertWidgetToPng(
    Widget widget, {
    double? pixelRatio,
    required double screenWidth,
    required double screenHeight,
  });

  Either<Failure, int> getTotalStreakScore();
}

class StreakDataSourceImpl extends StreakDataSource {
  final SharedPreferences prefs;

  StreakDataSourceImpl(this.prefs);

  // List<StreakModel> streakData = [
  //   StreakModel(
  //     timeStamp: DateTime(DateTime.now().year, DateTime.now().month, 13),
  //   ),
  //   StreakModel(
  //     timeStamp: DateTime(DateTime.now().year, DateTime.now().month, 14),
  //   ),
  //   StreakModel(
  //     timeStamp: DateTime(DateTime.now().year, DateTime.now().month, 15),
  //   ),
  //   StreakModel(
  //     timeStamp: DateTime(DateTime.now().year, DateTime.now().month, 16),
  //   ),
  //   StreakModel(
  //     timeStamp: DateTime(DateTime.now().year, DateTime.now().month, 17),
  //   ),
  //   // StreakModel(timeStamp: DateTime(DateTime.now().year, DateTime.now().month, 18)),
  //   // StreakModel(timeStamp: DateTime(DateTime.now().year, DateTime.now().month, 19)),
  //   StreakModel(
  //     timeStamp: DateTime(DateTime.now().year, DateTime.now().month, 20),
  //   ),
  // ];

  @override
  Either<Failure, List<StreakDisplayModel>> getLastSevenDaysStreakData() {
    final raw = prefs.getString(SP.streakData);
    if (raw != null) {
      List<StreakModel> streakData =
          (jsonDecode(raw) as List<dynamic>)
              .map((json) => StreakModel.fromJson(json))
              .toList();
      if (streakData.length > 7) {
        streakData = streakData.sublist(streakData.length - 7);
      }
      streakData.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));
      final now = DateTime.now();

      List<StreakDisplayModel> data = [];

      List<DateTime> checkInDates =
          streakData
              .map(
                (e) => DateTime(
                  e.timeStamp.year,
                  e.timeStamp.month,
                  e.timeStamp.day,
                ),
              )
              .toList();

      if (checkInDates.length < 7 && checkInDates.isNotEmpty) {
        for (int i = 0; i < 7; i++) {
          final date = DateTime(
            checkInDates[0].year,
            checkInDates[0].month,
            checkInDates[0].day,
          ).add(Duration(days: i));
          final isChecked = checkInDates.contains(date);
          final dayLabel = Utils.getWeekDayLabel(date.weekday);

          data.add(
            StreakDisplayModel(
              timeStamp: isChecked ? date : null,
              isMissed: false,
              // we'll handle this below
              isChecked: isChecked,
              isGift: false,
              dayLabel: dayLabel,
            ),
          );
        }
      } else {
        for (int i = 6; i >= 0; i--) {
          final date = DateTime(
            now.year,
            now.month,
            now.day,
          ).subtract(Duration(days: i));
          final isChecked = checkInDates.contains(date);
          final dayLabel = Utils.getWeekDayLabel(date.weekday);

          data.add(
            StreakDisplayModel(
              timeStamp: isChecked ? date : null,
              isMissed: false,
              // we'll handle this below
              isChecked: isChecked,
              isGift: false,
              dayLabel: dayLabel,
            ),
          );
        }
      }

      // Second pass to mark missed streaks
      int allowedOffDays = 2;

      for (int i = 0; i < data.length; i++) {
        // Only process if current day is checked
        if (!data[i].isChecked) continue;

        // Look ahead for next checked day within allowed gap
        for (
          int j = i + 1;
          j <= i + allowedOffDays + 1 && j < data.length;
          j++
        ) {
          if (data[j].isChecked) {
            // Found another check-in, mark all days in between as missed
            for (int k = i + 1; k < j; k++) {
              if (!data[k].isChecked) {
                data[k] = data[k].copyWith(isMissed: true);
              }
            }
            break; // Done with this streak segment
          }
        }
      }

      return Right(data);
    } else {
      return Left(UnknownFailure());
    }
  }

  @override
  Either<Failure, bool> isStreakBroken(
    List<StreakModel> streakData, {
    DateTime? currentDate,
  }) {
    return Right(_isStreakBroken(streakData, currentDate: currentDate));
  }

  bool _isStreakBroken(
    List<StreakModel> streakData, {
    int maxMissesAllowed = 2,
    DateTime? currentDate,
  }) {
    if (streakData.isEmpty) return true;

    final now = currentDate ?? DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Normalize all dates (remove time) and keep unique days only
    final checkInDates =
        streakData
            .map(
              (e) => DateTime(
                e.timeStamp.year,
                e.timeStamp.month,
                e.timeStamp.day,
              ),
            )
            .toList();

    if (checkInDates.length < 7) {
      List<DateTime> comparisonDays = [];

      for (
        DateTime date = checkInDates[0];
        !date.isAfter(checkInDates[checkInDates.length - 1]);
        date = date.add(Duration(days: 1))
      ) {
        comparisonDays.add(date);
      }

      final missedDays =
          comparisonDays.where((day) => !checkInDates.contains(day)).length;
      return missedDays > maxMissesAllowed;
    }

    // Check last 7 days (including today)
    final last7Days = List.generate(
      7,
      (i) => today.subtract(Duration(days: i)),
    );

    final missedDays =
        last7Days.where((day) => !checkInDates.contains(day)).length;

    return missedDays > maxMissesAllowed;
  }

  @override
  Either<Failure, StreakModel?> getLastCheckIn() {
    final raw = prefs.getString(SP.streakData);
    if (raw != null) {
      final List<StreakModel> streakData =
          (jsonDecode(raw) as List<dynamic>)
              .map((json) => StreakModel.fromJson(json))
              .toList();
      streakData.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));
      return Right(streakData.last);
    } else {
      return Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> logStreakEntry() async {
    final raw = prefs.getString(SP.streakData);

    final List<StreakModel> streakData =
        (raw != null)
            ? (jsonDecode(raw) as List<dynamic>)
                .map((json) => StreakModel.fromJson(json))
                .toList()
            : [];

    streakData.add(StreakModel(timeStamp: DateTime.now()));

    await prefs.setString(
      SP.streakData,
      jsonEncode(streakData.map((streak) => streak.toJson()).toList()),
    );

    return Right(unit);
  }

  @override
  Future<Either<Failure, void>> clearStreakData() async {
    // archiving
    final raw = prefs.getString(SP.streakData);
    final List<StreakModel> currentData =
        (raw != null)
            ? (jsonDecode(raw) as List<dynamic>)
                .map((json) => StreakModel.fromJson(json))
                .toList()
            : [];
    final archivedStatus = await prefs.setString(
      SP.streakDataArchive,
      jsonEncode(currentData.map((data) => data.toJson()).toList()),
    );
    if (!archivedStatus) {
      return Left(UnknownFailure());
    }

    // clearing
    final List<StreakModel> streakData = [];
    await prefs.setString(
      SP.streakData,
      jsonEncode(streakData.map((streak) => streak.toJson()).toList()),
    );

    return Right(unit);
  }

  @override
  Either<Failure, List<StreakModel>> getAllStreakData() {
    final raw = prefs.getString(SP.streakData);

    List<StreakModel> streakData =
        (raw != null)
            ? (jsonDecode(raw) as List<dynamic>)
                .map((json) => StreakModel.fromJson(json))
                .toList()
            : [];

    streakData.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));
    return Right(streakData);
  }

  @override
  Future<Either<Failure, String>> convertWidgetToPng(
    Widget widget, {
    double? pixelRatio,
    required double screenWidth,
    required double screenHeight,
  }) async {
    try {
      final repaintBoundary = RenderRepaintBoundary();
      final pipelineOwner = PipelineOwner();
      final buildOwner = BuildOwner(focusManager: FocusManager());

      // Initial layout with no size constraint to measure the widget
      final renderView = RenderView(
        child: RenderPositionedBox(
          alignment: Alignment.center,
          child: repaintBoundary,
        ),
        configuration: ViewConfiguration(
          physicalConstraints: const BoxConstraints(),
          logicalConstraints: const BoxConstraints(),
          devicePixelRatio: pixelRatio ?? 3,
        ),
        view: PlatformDispatcher.instance.implicitView!,
      );

      pipelineOwner.rootNode = renderView;
      renderView.prepareInitialFrame();

      final renderWidget = RenderObjectToWidgetAdapter<RenderBox>(
        container: repaintBoundary,
        child: widget,
      ).attachToRenderTree(buildOwner);

      buildOwner.buildScope(renderWidget);
      buildOwner.finalizeTree();
      pipelineOwner.flushLayout();

      // Get dynamic size from layout
      // final Size dynamicSize = repaintBoundary.size;
      // if (dynamicSize.isEmpty) {
      //   throw Exception("Rendered widget has zero size.");
      // }
      final Size dynamicSize = Size(screenWidth, screenHeight);

      final physicalSize = Size(
        dynamicSize.width * (pixelRatio ?? 3),
        dynamicSize.height * (pixelRatio ?? 3),
      );

      // Now that we have the size, prepare a second render with tight constraints
      final repaintBoundary2 = RenderRepaintBoundary();
      final renderView2 = RenderView(
        child: RenderPositionedBox(
          alignment: Alignment.center,
          child: repaintBoundary2,
        ),
        configuration: ViewConfiguration(
          physicalConstraints: BoxConstraints.tight(physicalSize),
          logicalConstraints: BoxConstraints.tight(dynamicSize),
          devicePixelRatio: pixelRatio ?? 3,
        ),
        view: PlatformDispatcher.instance.implicitView!,
      );

      final pipelineOwner2 = PipelineOwner();
      final buildOwner2 = BuildOwner(focusManager: FocusManager());

      pipelineOwner2.rootNode = renderView2;
      renderView2.prepareInitialFrame();

      final renderWidget2 = RenderObjectToWidgetAdapter<RenderBox>(
        container: repaintBoundary2,
        child: widget,
      ).attachToRenderTree(buildOwner2);

      buildOwner2.buildScope(renderWidget2);
      buildOwner2.finalizeTree();
      pipelineOwner2.flushLayout();
      pipelineOwner2.flushCompositingBits();
      pipelineOwner2.flushPaint();

      // Convert to image
      final image = await repaintBoundary2.toImage(pixelRatio: pixelRatio ?? 3);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = File(
        '${tempDir.path}/rendered_widget_${DateTime.now().toIso8601String()}.png',
      );
      await file.writeAsBytes(pngBytes);

      return Right(file.path);
    } catch (e) {
      debugPrint('Error rendering widget to PNG: $e');
      return Left(UnknownFailure());
    }
  }

  @override
  Either<Failure, int> getTotalStreakScore() {
    final raw = prefs.getString(SP.streakData);

    List<StreakModel> streakData =
        (raw != null)
            ? (jsonDecode(raw) as List<dynamic>)
                .map((json) => StreakModel.fromJson(json))
                .toList()
            : [];
    return Right(streakData.length);
  }
}
