import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class NotificationDetailSelector extends StatefulWidget {
  final Function(int value) onValueChanged;
  final bool? isFirst;
  final String title;
  final int count;

  const NotificationDetailSelector({
    super.key,
    required this.onValueChanged,
    this.isFirst,
    required this.title,
    required this.count,
  });

  @override
  State<NotificationDetailSelector> createState() =>
      _NotificationDetailSelectorState();
}

class _NotificationDetailSelectorState
    extends State<NotificationDetailSelector> {

  void _adjustCount(bool isIncrement) {
    if (isIncrement) {
      if (widget.count < 20) {
        widget.onValueChanged(widget.count + 1);
      }
    } else {
      if (widget.count > 0) {
        widget.onValueChanged(widget.count - 1);
      }
    }
  }

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
                widget.count > 0,
                Icons.remove_rounded,
                () => _adjustCount(false),
              ),
              SizedBox(
                width: 120,
                child: Text(
                  '${widget.count}x',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              adjustmentButton(
                widget.count < 20,
                Icons.add_rounded,
                () => _adjustCount(true),
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
}
