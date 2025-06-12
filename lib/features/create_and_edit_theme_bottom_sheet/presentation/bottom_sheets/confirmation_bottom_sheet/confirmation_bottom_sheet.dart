import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/theme/app_colors.dart';

class ConfirmationBottomSheet extends StatelessWidget {
  final VoidCallback onYesPressed;
  final VoidCallback onNoPressed;

  const ConfirmationBottomSheet({
    super.key,
    required this.onYesPressed,
    required this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          Container(
            width: 38,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(height: 20),
          OnboardingHeading(
            title: 'Leave without saving?',
            subTitle: 'You\'ll lose your changes',
            reduceMargins: true,
            disableTopMargin: true,
          ),
          SurelineButton(
            text: 'Leave',
            onPressed: onYesPressed,
            disableVerticalPadding: true,
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: onNoPressed,
            child: Text(
              'Keep editing',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
