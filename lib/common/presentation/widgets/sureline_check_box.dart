import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class SurelineCheckBox extends StatelessWidget {
  final bool isChecked;
  final bool? useTickForCheck;

  const SurelineCheckBox({
    super.key,
    required this.isChecked,
    this.useTickForCheck,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 250),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Container(
        key: ValueKey(isChecked),
        height: 20,
        width: 20,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(20),
          border:
              (isChecked)
                  ? null
                  : Border.all(
                    color: AppColors.primaryColor.withValues(alpha: 0.3),
                  ),
          color:
              (isChecked)
                  ? (useTickForCheck ?? false)
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withValues(alpha: 0.3)
                  : null,
        ),
        child:
            (isChecked)
                ? (useTickForCheck ?? false)
                    ? Center(
                      child: Icon(
                        size: 13,
                        Icons.check_rounded,
                        color: AppColors.white,
                      ),
                    )
                    : Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    )
                : null,
      ),
    );
  }
}
