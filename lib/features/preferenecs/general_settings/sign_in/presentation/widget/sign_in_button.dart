import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 0.5,
        )
      ),
      padding: EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.apple_rounded,
            color: AppColors.primaryColor.withValues(alpha: 0.5),
            // size: 30,
          ),
          Text('Sign in with Apple', style: TextStyle(
            fontSize: 16
          ),),
          Container(),
        ],
      ),
    );
  }
}
