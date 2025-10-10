import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/streak_container.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/common/domain/entities/streak_display_entity.dart';

/// Bottom sheet for displaying streak information and encouraging habit formation.
/// This component provides a comprehensive view of the user's streak progress
/// with motivational content and commitment options.
///
/// The bottom sheet includes visual elements, streak display, and interactive
/// elements to encourage daily quote practice habits.
class StreakBottomSheet extends StatelessWidget {
  /// The list of streak display entities containing the user's streak data.
  /// Each entity represents a day with its completion status and special states.
  final List<StreakDisplayEntity> entities;

  const StreakBottomSheet({super.key, required this.entities});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: Utils.bottomSheetDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildDragHandle(),
          Spacer(),
          _buildVisualElement(),
          _buildMotivationalContent(),
          _buildStreakContainer(),
          _buildCommitmentButton(context),
        ],
      ),
    );
  }

  /// Builds the drag handle indicator at the top of the bottom sheet.
  /// Provides visual feedback for the draggable nature of the sheet.
  ///
  /// Returns a Container widget with the drag handle
  Widget _buildDragHandle() {
    return Container(
      width: 37,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.primaryColor.withValues(alpha: 0.3),
      ),
    );
  }

  /// Builds the visual element placeholder for the streak display.
  /// Currently uses a placeholder, can be replaced with custom visual content.
  ///
  /// Returns a SizedBox widget with placeholder content
  Widget _buildVisualElement() {
    return SizedBox(height: 235, width: 235, child: Image.asset('assets/images/sparkle.png'));
  }

  /// Builds the motivational content with heading and description.
  /// Encourages users to build daily habits through streak tracking.
  ///
  /// Returns an OnboardingHeading widget with motivational content
  Widget _buildMotivationalContent() {
    return OnboardingHeading(
      title: 'A new daily habit!',
      subTitle: 'Build a streak to make practicing quotes a habit that sticks!',
      disableMargins: true,
    );
  }

  /// Builds the streak container with the user's current streak data.
  /// Displays the 7-day streak progress with visual indicators.
  ///
  /// Returns a StreakContainer widget
  Widget _buildStreakContainer() {
    return StreakContainer(entities: entities, showShare: false);
  }

  /// Builds the commitment button for user interaction.
  /// Allows users to commit to building their streak habit.
  ///
  /// [context] - The build context for navigation
  /// Returns a SurelineButton widget
  Widget _buildCommitmentButton(BuildContext context) {
    return SurelineButton(
      text: 'I commit to 3 days',
      onPressed: () {
        _handleCommitment(context);
      },
    );
  }

  /// Handles the commitment button press.
  /// Closes the bottom sheet when the user commits to the streak.
  ///
  /// [context] - The build context for navigation
  void _handleCommitment(BuildContext context) {
    Navigator.of(context).pop();
  }
}
