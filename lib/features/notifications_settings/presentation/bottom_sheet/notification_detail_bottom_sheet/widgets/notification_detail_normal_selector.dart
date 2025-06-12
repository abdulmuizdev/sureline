import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class NotificationDetailNormalSelector extends StatelessWidget {
  final VoidCallback onPressed;
  final bool? isFirst;
  final bool? isLast;
  final String title;
  final String actionTitle;

  const NotificationDetailNormalSelector({
    super.key,
    required this.onPressed,
    this.isFirst,
    this.isLast,
    required this.title,
    required this.actionTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.white2,
        borderRadius: BorderRadius.only(
          topLeft:
              (isFirst ?? false) ? Radius.circular(10) : Radius.zero,
          topRight:
              (isFirst ?? false) ? Radius.circular(10) : Radius.zero,
          bottomLeft:
          (isLast ?? false) ? Radius.circular(10) : Radius.zero,
          bottomRight:
          (isLast ?? false) ? Radius.circular(10) : Radius.zero,
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
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ),
          Row(
            children: [
              Text(
                actionTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(width: 18),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.primaryColor,
                size: 12,
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
