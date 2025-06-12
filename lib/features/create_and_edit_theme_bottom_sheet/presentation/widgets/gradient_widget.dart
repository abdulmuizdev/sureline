import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class GradientWidget extends StatelessWidget {
  final bool? reverse;

  const GradientWidget({super.key, this.reverse});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor.withValues(
              alpha: (reverse ?? false) ? 0 : 0.3,
            ),
            AppColors.primaryColor.withValues(
              alpha: (reverse ?? false) ? 0.3 : 0,
            ),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
