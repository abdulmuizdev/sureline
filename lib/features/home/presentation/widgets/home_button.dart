/// Custom button widget for home screen actions.
///
/// Provides consistent styling for home screen buttons.

import 'package:flutter/material.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/theme/app_colors.dart';

/// Custom button widget for home screen interactions.
class HomeButton extends StatelessWidget {
  final IconData icon;
  const HomeButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: App.homeButtonColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.25),
              offset: Offset.zero,
              blurRadius: 30.5,
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.primaryColor),
      ),
    );
  }
}
