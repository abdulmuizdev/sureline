import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sureline/common/presentation/widgets/sureline_overlay.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:throttling/throttling.dart';

/// Widget for selecting notification times during onboarding.
/// This component provides an interactive time picker with overlay functionality,
/// haptic feedback, and sound effects for a premium user experience.
///
/// The widget includes throttled sound effects, scroll detection,
/// and proper state management for time selection.
class TimeSelector extends StatefulWidget {
  /// Whether this is the last time selector in the list.
  /// Affects the border radius styling.
  final bool? isLast;

  /// The currently selected time in string format.
  /// Displayed in the time button.
  final TimeOfDay time;

  /// Whether the time picker overlay is currently visible.
  /// Controls the display of the CupertinoDatePicker.
  final bool isOverlayVisible;

  /// Callback function triggered when the overlay visibility changes.
  /// Used to manage overlay state in the parent component.
  final Function(bool) onOverlayToggled;

  /// Callback function triggered when the time selection changes.
  /// Provides the new time string to the parent component.
  final Function(TimeOfDay) onTimeChange;

  final String label;

  final bool isFirst;

  const TimeSelector({
    super.key,
    this.isLast,
    required this.time,
    required this.isOverlayVisible,
    required this.onOverlayToggled,
    required this.onTimeChange,
    required this.label,
    required this.isFirst,
  });

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  /// The most recent time value selected by the user.
  /// Used to track changes and provide to the parent component.
  late TimeOfDay _latestTime;

  /// Throttling instance to limit sound effect frequency.
  /// Prevents excessive sound playback during rapid scrolling.
  late Throttling _throttler;

  /// Frequency limit for sound effects in hertz.
  static const int hzLimit = 50;

  /// Minimum gap between sound effects to prevent overwhelming audio.
  static const Duration minGap = Duration(milliseconds: 1000 ~/ hzLimit);

  @override
  void initState() {
    super.initState();
    _latestTime = widget.time;
    _throttler = Throttling(duration: minGap);
  }

  /// Handles the end of scrolling in the time picker.
  /// Sends the final selected time to the parent component.
  void _onScrollEnd() {
    widget.onTimeChange(_latestTime);
  }

  /// Plays a tick sound effect with throttling to prevent audio spam.
  /// Uses a platform channel to play native iOS sound effects.
  void _playTickSound() {
    _throttler.throttle(() {
      try {
        const MethodChannel('com.abdulmuiz.sureline/wheelSound').invokeMethod('playTickSound');
      } on PlatformException catch (e) {
        debugPrint("Failed to play sound: ${e.message}");
      }
    });
  }

  /// Handles time changes from the CupertinoDatePicker.
  /// Updates the local state and triggers sound effects.
  ///
  /// [newTime] - The new DateTime selected by the user
  void _onTimeChanged(DateTime newTime) async {
    setState(() {
      _latestTime = TimeOfDay.fromDateTime(newTime);
    });
    _playTickSound();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(color: AppColors.white2, borderRadius: _getBorderRadius()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ),
          SurelineOverlay(
            onClose: () => widget.onOverlayToggled(false),
            overlay: _buildTimePickerOverlay(),
            visible: widget.isOverlayVisible,
            child: _buildTimeButton(),
          ),
        ],
      ),
    );
  }

  /// Returns the appropriate border radius based on whether this is the last selector.
  ///
  /// Returns a BorderRadius object for proper styling.
  BorderRadius _getBorderRadius() {
    if (widget.isFirst && (widget.isLast ?? false)) {
      return const BorderRadius.all(Radius.circular(10));
    } else if (widget.isFirst) {
      return const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10));
    } else if (widget.isLast ?? false) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      );
    } else {
      return const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      );
    }
  }

  /// Builds the time picker overlay with CupertinoDatePicker.
  /// Includes scroll detection and custom styling.
  ///
  /// Returns a Container widget containing the time picker.
  Widget _buildTimePickerOverlay() {
    return Container(
      width: 230,
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.1),
            blurRadius: 140,
            offset: Offset.zero,
          ),
        ],
      ),
      child: CupertinoTheme(
        data: const CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        child: NotificationListener<ScrollEndNotification>(
          onNotification: (scrollEnd) {
            _onScrollEnd();
            return true;
          },
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: _onTimeChanged,
          ),
        ),
      ),
    );
  }

  /// Builds the time selection button that triggers the overlay.
  /// Displays the current time and handles tap events.
  ///
  /// Returns a GestureDetector widget with styled time display.
  Widget _buildTimeButton() {
    return GestureDetector(
      onTap: () => widget.onOverlayToggled(true),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 11),
          child: Text(
            widget.time.format(context),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
