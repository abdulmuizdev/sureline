import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

/// Widget for displaying individual streak days in the streak container.
/// This component shows a single day of the week with its completion status,
/// including special states for gifts and missed days.
///
/// The widget includes visual indicators for different states (completed, missed, gift)
/// and supports animation for highlighting the current streak progress.
class StreakItem extends StatelessWidget {
  /// Whether this day is completed in the streak.
  /// Controls the visual appearance and icon display.
  final bool isChecked;

  /// Whether this day represents a gift/reward day.
  /// Shows a gift icon when true and not checked.
  final bool? isGift;

  /// Whether this day represents a missed day.
  /// Shows a missed day icon when true and not checked.
  final bool? isMissed;

  /// The day label to display (e.g., "Mon", "Tue").
  /// Shown above the streak indicator.
  final String day;

  /// Whether this item should animate its selection.
  /// Used to highlight the current streak progress.
  final bool? animateSelection;

  const StreakItem({
    super.key,
    required this.isChecked,
    this.isGift,
    this.isMissed,
    this.animateSelection,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [_buildDayLabel(), SizedBox(height: 11), _buildStreakIndicator()],
    );
  }

  /// Builds the day label text above the streak indicator.
  ///
  /// Returns a Text widget with the day label
  Widget _buildDayLabel() {
    return Text(day, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500));
  }

  /// Builds the streak indicator with appropriate styling and icons.
  ///
  /// Returns a Container widget with the streak indicator
  Widget _buildStreakIndicator() {
    return Container(
      width: 30,
      height: 30,
      decoration: _buildIndicatorDecoration(),
      child: Stack(children: [_buildCheckedIcon(), _buildSpecialStateIcon()]),
    );
  }

  /// Builds the decoration for the streak indicator based on completion status.
  ///
  /// Returns a BoxDecoration with appropriate styling
  BoxDecoration _buildIndicatorDecoration() {
    return BoxDecoration(
      color: isChecked ? null : AppColors.primaryColor.withValues(alpha: 0.1),
      gradient:
          isChecked
              ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.pink, AppColors.pink.withValues(alpha: 0.5)],
              )
              : null,
      borderRadius: BorderRadius.circular(30),
    );
  }

  /// Builds the check icon for completed days.
  ///
  /// Returns a Center widget with check icon or empty container
  Widget _buildCheckedIcon() {
    if (isChecked) {
      return const Center(child: Icon(Icons.check_rounded, color: AppColors.white, size: 15));
    }
    return const SizedBox.shrink();
  }

  /// Builds special state icons for missed days or gift days.
  ///
  /// Returns a Center widget with appropriate icon or empty container
  Widget _buildSpecialStateIcon() {
    if (!isChecked && ((isMissed ?? false) || (isGift ?? false))) {
      return Center(
        child: Icon(
          (isMissed ?? false) ? Icons.ac_unit_rounded : Icons.card_giftcard_rounded,
          size: 15,
          color: AppColors.primaryColor.withValues(alpha: 0.5),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
