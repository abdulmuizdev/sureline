import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class SetAsWatchFaceButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SetAsWatchFaceButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          'Set as Watch face',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
