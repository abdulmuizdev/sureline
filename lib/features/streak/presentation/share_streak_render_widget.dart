import 'package:flutter/material.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/common/presentation/widgets/watermark.dart';

/// Widget for rendering streak achievements for social media sharing.
///
/// This widget creates a visually appealing streak display that users can
/// share on social media platforms. It combines the user's streak count
/// with motivational messaging and premium visual design to create
/// shareable content that promotes the app and celebrates user achievements.
///
/// Key Features:
/// - Dynamic streak count display with premium typography
/// - Motivational messaging and branding
/// - Premium visual design with background integration
/// - Watermark for app promotion
/// - Responsive layout for different screen sizes
/// - Social media optimized design
///
/// Visual Design:
/// - Clean, minimalist layout with focus on streak number
/// - Premium typography with consistent app branding
/// - Background integration for visual appeal
/// - Watermark placement for brand recognition
/// - Optimized for social media aspect ratios
///
/// Sharing Integration:
/// - Designed for Instagram story and post sharing
/// - Optimized for Facebook and other social platforms
/// - Maintains visual quality across different platforms
/// - Includes app branding for organic growth
///
/// Usage:
/// ```dart
/// ShareStreakRenderWidget(
///   streakScore: '7',
///   width: 1080,
///   height: 1920,
/// )
/// ```
class ShareStreakRenderWidget extends StatelessWidget {
  /// The user's current streak count to display.
  final String streakScore;

  /// Optional width for responsive design.
  final double? width;

  /// Optional height for responsive design.
  final double? height;

  /// Creates a new ShareStreakRenderWidget instance.
  const ShareStreakRenderWidget({super.key, required this.streakScore, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: AppColors.pureWhite,
        child: Stack(
          children: [
            // Full-screen background for visual appeal
            Positioned.fill(child: Background(width: width, height: height, isStatic: true)),
            // Centered content with scaling for optimal display
            Transform.scale(
              scale: 1,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Streak count display with placeholder for icon
                    SizedBox(
                      width: 150,
                      height: 130,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          // Placeholder for achievement icon
                          SizedBox(
                            width: 140,
                            height: 80,
                            child: Image.asset(
                              'assets/images/sparkle.png',
                              color: AppColors.primaryColor,
                            ),
                          ),
                          // Large, prominent streak number
                          Text(
                            streakScore,
                            style: const TextStyle(
                              fontSize: 40,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Motivational messaging with app branding
                    const OnboardingHeading(
                      title: 'day streak',
                      subTitle: 'practicing positive energy quotes',
                      disableTopMargin: true,
                      reduceMargins: true,
                      textColor: AppColors.primaryColor,
                    ),

                    SizedBox(height: 30),
                    // App watermark for brand recognition
                    Watermark(overrideColor: AppColors.primaryColor),
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
