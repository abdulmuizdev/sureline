import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class ContentPrefGridItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onPressed;

  const ContentPrefGridItem({super.key, required this.isSelected,
  required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border:
              isSelected
                  ? null
                  : Border.all(color: AppColors.primaryColor, width: 1),
          color: isSelected ? AppColors.peach : AppColors.pureWhite,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color:
                  isSelected
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withValues(alpha: 0.7),
            ),
          ),
        ),
      ),
    );
  }
}
