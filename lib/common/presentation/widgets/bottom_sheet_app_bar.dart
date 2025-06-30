import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class BottomSheetAppBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final bool showIcon;
  final bool showText;

  const BottomSheetAppBar({
    super.key,
    required this.title,
    required this.onBack,
    this.showIcon = true,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBack,
      child: Row(
        children: [
          if (showIcon)
            Icon(
              Icons.keyboard_arrow_left_rounded,
              color: AppColors.primaryColor,
            ),
          if (showText)
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            ),
        ],
      ),
    );
  }
}
