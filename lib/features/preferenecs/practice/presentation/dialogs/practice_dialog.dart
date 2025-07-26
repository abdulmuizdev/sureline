import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';

/// Practice mode selection dialog for quote meditation sessions.
///
/// This dialog presents users with different practice duration options
/// for focused quote reading and internalization. The practice feature
/// allows users to engage in mindful reading sessions where quotes
/// are displayed for specific durations to encourage deep reflection.
///
/// Key Features:
/// - Three practice duration options (1 min, 5 min, 15 min)
/// - Clear instructions on practice methodology
/// - Premium dialog design with rounded corners
/// - Seamless integration with practice bottom sheet
///
/// UX Flow:
/// 1. User selects "Practice" from preferences
/// 2. Dialog appears with duration options
/// 3. User selects duration and dialog returns selection
/// 4. Practice bottom sheet launches with selected duration
/// 5. Quotes display sequentially with story view animation
///
/// Design Considerations:
/// - Uses premium dialog styling with 30px border radius
/// - Implements close button for easy dismissal
/// - Provides clear practice instructions
/// - Maintains consistent button styling with app theme
///
/// Usage:
/// ```dart
/// final int? selectedDuration = await showGeneralDialog<int>(
///   context: context,
///   pageBuilder: (context, animation, secondaryAnimation) =>
///     Center(child: PracticeDialog()),
/// );
/// ```
class PracticeDialog extends StatelessWidget {
  /// Creates a new PracticeDialog instance.
  const PracticeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AppColors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close button positioned at top-left
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
            // Placeholder for practice icon/illustration
            SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                children: [
                  Image.asset('assets/images/sparkle.png'),
                  Image.asset('assets/images/play.png'),
                ],
              ),
            ),
            // Practice instructions and title
            OnboardingHeading(
              disableTopMargin: true,
              title: 'Practice quotes:\nGeneral',
              subTitle:
                  'You\'ll get a new quote every few seconds.\n\nRead each one, focusing on the meaning.\n\nInternalize it.\n\nRepeat.',
              disableMargins: true,
            ),

            // Quick boost option - 1 minute session
            SurelineButton(
              text: 'Quick boost (1 min)',
              onPressed: () {
                Navigator.of(context).pop(0);
              },
              disableVerticalPadding: true,
            ),
            SizedBox(height: 10),
            // Regular practice option - 5 minute session
            SurelineButton(
              text: 'Regular (5 min)',
              onPressed: () {
                Navigator.of(context).pop(1);
              },
              disableVerticalPadding: true,
            ),
            SizedBox(height: 10),
            // Expert practice option - 15 minute session
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
