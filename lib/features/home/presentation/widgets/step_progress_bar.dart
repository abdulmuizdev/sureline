import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class StepProgressBar extends StatelessWidget {
  final int value; // should be from 0 to 5
  final int maxValue;

  const StepProgressBar({
    super.key,
    required this.value,
    required this.maxValue,
  });

  @override
  Widget build(BuildContext context) {
    final double fillPercent = (value.clamp(0, 5)) / maxValue;

    return Stack(
      children: [
        // Background Bar
        Container(
          width: 90,
          height: 6,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        // Filled Bar
        Container(
          width: 90 * fillPercent,
          height: 6,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ],
    );
  }
}
