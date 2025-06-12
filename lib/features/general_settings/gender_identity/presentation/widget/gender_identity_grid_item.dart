import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class GenderIdentityGridItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onPressed;

  const GenderIdentityGridItem({super.key, required this.isSelected,
  required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(15),
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
      ),
    );
  }
}
