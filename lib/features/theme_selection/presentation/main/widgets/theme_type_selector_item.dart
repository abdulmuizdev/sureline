import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class ThemeTypeSelectorItem extends StatelessWidget {
  final IconData? icon;
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const ThemeTypeSelectorItem({
    super.key,
    this.icon,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          // width: 95,
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22),
              topRight: Radius.circular(22),
              bottomLeft: Radius.circular(19.5),
              bottomRight: Radius.circular(19.5),
            ),
            color: (isSelected) ? AppColors.primaryColor : AppColors.pureWhite,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color:
                      (isSelected) ? AppColors.white : AppColors.primaryColor,
                  size: 14 * 2,
                ),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:
                      (isSelected) ? AppColors.white : AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
