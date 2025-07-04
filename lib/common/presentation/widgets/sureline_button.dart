import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class SurelineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool? disableVerticalPadding;
  final bool? disableHorizontalPadding;
  final bool? isOutlined;
  final bool? isDisabled;

  const SurelineButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.disableVerticalPadding,
    this.disableHorizontalPadding,
    this.isOutlined,
    this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: (disableHorizontalPadding ?? false) ? 0 : 24,
        vertical: (disableVerticalPadding ?? false) ? 0 : 50,
      ),
      child: GestureDetector(
        onTap: (isDisabled ?? false) ? null : onPressed,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color:
                (isOutlined ?? false)
                    ? null
                    : (isDisabled ?? false)
                    ? AppColors.primaryColor.withValues(alpha: 0.5)
                    : AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
            border:
                (isOutlined ?? false)
                    ? Border.all(
                      color: AppColors.primaryColor.withValues(alpha: 0.5),
                      width: 1,
                    )
                    : null,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color:
                    (isOutlined ?? false)
                        ? AppColors.primaryColor
                        : AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
