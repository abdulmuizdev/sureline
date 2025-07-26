import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

/// Widget that displays a single user review in the onboarding carousel.
/// This component renders a review with star rating and testimonial text,
/// providing a consistent visual layout for user feedback presentation.
///
/// The widget is used in the GettingStartedScreen to display user reviews
/// in an auto-scrolling carousel, helping to build trust and showcase
/// the app's value to new users.
class ReviewListItem extends StatelessWidget {
  /// The number of stars to display for this review's rating.
  /// This value determines how many star icons are rendered.
  final int starCount;

  /// The testimonial text content from the user review.
  /// This text is displayed in quotes below the star rating.
  final String reviewText;

  const ReviewListItem({super.key, required this.starCount, required this.reviewText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SizedBox(
          width: 270,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(starCount, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Image.asset('assets/images/star.png', width: 17, height: 17),
                  );
                }),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Text(
                  '"$reviewText"',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
