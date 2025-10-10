import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/theme/app_colors.dart';

class LikeDetailBottomSheet extends StatelessWidget {
  const LikeDetailBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          Container(
            width: 37,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(height: 45),
          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              children: [
                Icon(CupertinoIcons.heart_fill, size: 100, color: AppColors.primaryColor),
                Image.asset('assets/images/sparkle.png'),
              ],
            ),
          ),
          OnboardingHeading(
            title: 'Quotes that resonate',
            subTitle: 'Favourite 5 quotes to personalize your feed',
            reduceMargins: true,
          ),
          SurelineButton(
            text: 'Got it!',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
