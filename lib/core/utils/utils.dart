import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/notifications_settings/domain/entity/day_entity.dart';

class Utils {
  static Widget Function(
    BuildContext,
    Animation<double>,
    Animation<double>,
    Widget,
  )
  dialogTransitionBuilder = (
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.easeOutCubic;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  };
  static String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute$period';
  }

  static TimeOfDay stringToTime(String s) {
    final parts = s.split(':');
    final h = int.parse(parts[0]);
    final m = int.parse(parts[1]);
    return TimeOfDay(hour: h, minute: m);
  }

  static String getNotificationPresetSubtitle(List<DayEntity> days) {
    final selectedDays = days.where((day) => day.isSelected == true).toList();
    if (selectedDays.length == days.length) {
      return 'Every Day';
    } else {
      String subtitle = '';
      for (DayEntity entity in selectedDays) {
        subtitle =
            '$subtitle, ${getWeekDayLabel(entity.dateTime, threeChars: true)}';
      }
      return subtitle;
    }
  }

  static String timeToString(TimeOfDay t) => '${t.hour}:${t.minute}';
  static void updateWidgets() async {
    const platform = MethodChannel('com.abdulmuiz.sureline.quoteWidget');
    debugPrint(await platform.invokeMethod('triggerWidgetUpdate'));
  }

  static String getWeekDayLabel(int weekDay, {bool? threeChars}) {
    switch (weekDay) {
      case DateTime.monday:
        return (threeChars ?? false) ? "Mon" : "Mo";
      case DateTime.tuesday:
        return (threeChars ?? false) ? "Tue" : "Tu";
      case DateTime.wednesday:
        return (threeChars ?? false) ? "Wed" : "We";
      case DateTime.thursday:
        return (threeChars ?? false) ? "Thu" : "Th";
      case DateTime.friday:
        return (threeChars ?? false) ? "Fri" : "Fr";
      case DateTime.saturday:
        return (threeChars ?? false) ? "Sat" : "Sa";
      default:
        return (threeChars ?? false) ? "Sun" : "Su";
    }
  }

  static String getMonthLabel(int month) {
    switch (month) {
      case DateTime.january:
        return "Jan";
      case DateTime.february:
        return "Feb";
      case DateTime.march:
        return "Mar";
      case DateTime.april:
        return "Apr";
      case DateTime.may:
        return "May";
      case DateTime.june:
        return "Jun";
      case DateTime.july:
        return "Jul";
      case DateTime.august:
        return "Aug";
      case DateTime.september:
        return "Sep";
      case DateTime.october:
        return "Oct";
      case DateTime.november:
        return "Nov";
      case DateTime.december:
        return "Dec";
      default:
        return "";
    }
  }

  static void showCustomSnackBar(BuildContext context, Widget widget) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    final controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: Navigator.of(context),
    );

    final animation = Tween<Offset>(
      begin: Offset(0, -1), // Start above screen
      end: Offset(0, 0.5), // Slide into position
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutBack));

    entry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: SlideTransition(
                position: animation,
                child: Center(child: widget),
              ),
            ),
          ),
    );

    overlay.insert(entry);
    controller.forward();

    // Auto dismiss
    Future.delayed(Duration(seconds: 4), () async {
      await controller.reverse();
      entry.remove();
      controller.dispose();
    });
  }

  static BoxDecoration bottomSheetDecoration({bool? ignoreCorners}) {
    return BoxDecoration(
      borderRadius:
          (ignoreCorners ?? false)
              ? null
              : BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
      color: AppColors.white,
    );
  }
}
