import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sureline/core/theme/app_colors.dart';

class ReportedSnackbar extends StatelessWidget {
  const ReportedSnackbar({super.key});

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
          Icon(Icons.flag_outlined, size: 20, color: AppColors.primaryColor),
          SizedBox(width: 10),
          Text(
            'Reported, thank you!',
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
