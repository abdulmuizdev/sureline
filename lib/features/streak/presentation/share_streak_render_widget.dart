import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/common/presentation/widgets/watermark.dart';

class ShareStreakRenderWidget extends StatelessWidget {
  final String streakScore;
  const ShareStreakRenderWidget({super.key, required this.streakScore});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: AppColors.pureWhite,
        child: Stack(
          children: [
            Positioned.fill(child: Background()),
            Transform.scale(
              scale: 1,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 150,
                      height: 130,
                      decoration: BoxDecoration(),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Placeholder(),
                          Text(
                            streakScore,
                            style: TextStyle(
                              fontSize: 40,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    OnboardingHeading(
                      title: 'day streak',
                      subTitle: 'practicing positive energy quotes',
                      disableTopMargin: true,
                      reduceMargins: true,
                    ),

                    SizedBox(height: 30),
                    Watermark(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
