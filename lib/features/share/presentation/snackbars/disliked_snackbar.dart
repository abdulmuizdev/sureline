import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sureline/core/theme/app_colors.dart';

class DislikedSnackbar extends StatelessWidget {
  const DislikedSnackbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 52,

      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.thumb_down_off_alt_rounded,
            size: 20,
            color: AppColors.primaryColor,
          ),
          SizedBox(width: 10),
          Text(
            'Disliked',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
