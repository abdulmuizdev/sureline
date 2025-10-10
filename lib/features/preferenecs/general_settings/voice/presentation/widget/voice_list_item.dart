import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/sureline_check_box.dart';
import 'package:sureline/core/theme/app_colors.dart';

class VoiceListItem extends StatelessWidget {
  final bool? isFirst;
  final bool? isLast;
  final String title;
  final String subTitle;
  final VoidCallback? onPressed;
  final bool isSelected;

  const VoiceListItem({
    super.key,
    this.isLast,
    required this.title,
    required this.subTitle,
    this.isFirst,
    this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.only(
            topLeft: (isFirst ?? false) ? Radius.circular(10) : Radius.zero,
            topRight: (isFirst ?? false) ? Radius.circular(10) : Radius.zero,
            bottomLeft: (isLast ?? false) ? Radius.circular(10) : Radius.zero,
            bottomRight: (isLast ?? false) ? Radius.circular(10) : Radius.zero,
          ),
          border:
              (isLast ?? false)
                  ? null
                  : Border(
                    bottom: BorderSide(
                      color: AppColors.primaryColor.withValues(alpha: 0.3),
                      width: 0.5,
                    ),
                  ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppColors.primaryColor,
                  ),
                ),

                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: AppColors.primaryColor.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
            SurelineCheckBox(isChecked: isSelected, useTickForCheck: true),
          ],
        ),
      ),
    );
  }
}
