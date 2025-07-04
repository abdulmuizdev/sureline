import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';

class PracticeDialog extends StatelessWidget {
  const PracticeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close_rounded,
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                ),
              ),
            ),
            SizedBox(width: 100, height: 100, child: Placeholder()),
            // Spacer(),
            OnboardingHeading(
              disableTopMargin: true,
              title: 'Practice quotes:\nGeneral',
              subTitle:
                  'You\'ll get a new quote every few seconds.\n\nRead each one, focusing on the meaning.\n\nInternalize it.\n\nRepeat.',
              disableMargins: true,
            ),

            SurelineButton(
              text: 'Quick boost (1 min)',
              onPressed: () {
                Navigator.of(context).pop(0);
              },
              disableVerticalPadding: true,
            ),
            SizedBox(height: 10),
            SurelineButton(
              text: 'Regular (5 min)',
              onPressed: () {
                Navigator.of(context).pop(1);
              },
              disableVerticalPadding: true,
            ),
            SizedBox(height: 10),
            SurelineButton(
              text: 'Expert (15 min)',
              onPressed: () {
                Navigator.of(context).pop(2);
              },
              disableVerticalPadding: true,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
