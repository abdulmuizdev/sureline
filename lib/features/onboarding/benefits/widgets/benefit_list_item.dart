import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

/// Widget that displays a single benefit item in the onboarding benefits list.
/// This component renders an individual benefit with an icon placeholder and
/// descriptive text, providing a consistent visual layout for benefit presentation.
///
/// The widget is used in the BenefitsScreen to display each benefit retrieved
/// from remote configuration, ensuring uniform styling and spacing.
class BenefitListItem extends StatelessWidget {
  /// The text content describing the specific benefit.
  /// This text is displayed next to the benefit icon and explains
  /// one of the advantages of using Sureline.
  final String benefitText;
  final String imagePath;

  const BenefitListItem({super.key, required this.benefitText, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 17),
      child: Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
              child: Image.asset(imagePath),
            ),
          ),
          const SizedBox(width: 11),
          Text(
            benefitText,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
