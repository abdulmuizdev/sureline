import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class SurelineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool? disableVerticalPadding;
  final bool? disableHorizontalPadding;

  const SurelineButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.disableVerticalPadding,
    this.disableHorizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: (disableHorizontalPadding ?? false) ? 0 : 24,
        vertical: (disableVerticalPadding ?? false) ? 0 : 50,
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
