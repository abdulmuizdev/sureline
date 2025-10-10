import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class FeedSetupSnackBar extends StatelessWidget {
  const FeedSetupSnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.favorite_outline_rounded,
            color: AppColors.primaryColor,
            size: 25,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your feed’s set up! Personalize it even '
                  'more by adding more quotes to favourites.',

              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryColor,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
