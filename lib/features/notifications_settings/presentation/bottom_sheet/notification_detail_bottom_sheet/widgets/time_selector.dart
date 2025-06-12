import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sureline/core/theme/app_colors.dart';

class TimeSelector extends StatefulWidget {
  final Function(DateTime time) onValueChanged;
  final bool? isFirst;
  final String title;
  final DateTime time;

  const TimeSelector({
    super.key,
    required this.onValueChanged,
    this.isFirst,
    required this.title,
    required this.time,
  });

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  bool _isMinusEnabled = true;
  bool _isPlusEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.only(
          topLeft:
              (widget.isFirst ?? false) ? Radius.circular(10) : Radius.zero,
          topRight:
              (widget.isFirst ?? false) ? Radius.circular(10) : Radius.zero,
        ),
        border: Border(
          bottom: BorderSide(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            width: 0.3,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              adjustmentButton(
                _isMinusEnabled,
                Icons.remove_rounded,
                () => _modifyTime(widget.time, false),
              ),

              SizedBox(
                width: 120,
                child: Text(
                  DateFormat.jm().format(widget.time),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              adjustmentButton(
                _isPlusEnabled,
                Icons.add_rounded,
                () => _modifyTime(widget.time, true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget adjustmentButton(
    bool isEnabled,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        width: 31,
        height: 31,
        decoration: BoxDecoration(
          color:
              isEnabled
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(icon, color: AppColors.pureWhite),
      ),
    );
  }

  DateTime _modifyTime(DateTime initialTime, bool isAdd) {
    final newTime =
        isAdd
            ? initialTime.add(Duration(minutes: 30))
            : initialTime.subtract(Duration(minutes: 30));
    widget.onValueChanged(newTime);
    return newTime;
  }
}
