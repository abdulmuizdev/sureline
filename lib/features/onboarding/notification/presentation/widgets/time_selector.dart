import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sureline/common/presentation/widgets/sureline_overlay.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:throttling/throttling.dart';

class TimeSelector extends StatefulWidget {
  final bool? isLast;
  final String time;
  final bool isOverlayVisible;
  final Function(bool) onOverlayToggled;
  final Function(String) onTimeChange;

  const TimeSelector({
    super.key,
    this.isLast,
    required this.time,
    required this.isOverlayVisible,
    required this.onOverlayToggled,
    required this.onTimeChange,
  });

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  late String _latestTime;
  late Throttling _throttler;
  static const int hzLimit = 50;
  static final Duration minGap = Duration(milliseconds: 1000 ~/ hzLimit);

  @override
  void initState() {
    super.initState();
    _latestTime = widget.time;
    _throttler = Throttling(duration: minGap);
  }

  void _onScrollEnd() {
    widget.onTimeChange(_latestTime);
  }

  void _playTickSound() {
    _throttler.throttle(() {
      try {
        MethodChannel(
          'com.abdulmuiz.sureline/wheelSound',
        ).invokeMethod('playTickSound');
      } on PlatformException catch (e) {
        debugPrint("Failed to play sound: ${e.message}");
      }
    });
  }

  void _onTimeChanged(DateTime newTime) async {
    setState(() {
      _latestTime = DateFormat('h:mm a').format(newTime);
    });
    _playTickSound();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.white2,
        borderRadius:
            (widget.isLast ?? false)
                ? const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )
                : const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'How many',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ),
          SurelineOverlay(
            onClose: () => widget.onOverlayToggled(false),
            overlay: Container(
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
                data: CupertinoThemeData(
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
            ),
            visible: widget.isOverlayVisible,
            child: GestureDetector(
              onTap: () => widget.onOverlayToggled(true),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 11,
                  ),
                  child: Text(
                    widget.time,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
