import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

/// A reusable back button component with customizable title and icon.
/// This widget provides a consistent back navigation experience across
/// the app with optional back arrow icon and customizable text.
///
/// The button includes tap handling for navigation and proper styling
/// that matches the app's design system.
class SurelineBackButton extends StatelessWidget {
  /// The title text to display in the back button.
  /// Usually indicates the previous screen or action.
  final String title;

  /// Whether to show the back arrow icon.
  /// Defaults to true, can be disabled for different contexts.
  final bool? showBackIcon;

  const SurelineBackButton({super.key, required this.title, this.showBackIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _handleBackNavigation(context);
      },
      child: Row(children: [_buildBackIcon(), _buildTitleText()]),
    );
  }

  /// Handles the back navigation when the button is tapped.
  /// Uses Navigator.pop() to return to the previous screen.
  ///
  /// [context] - The build context for navigation
  void _handleBackNavigation(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// Builds the back arrow icon with conditional visibility.
  ///
  /// Returns an Icon widget or empty container
  Widget _buildBackIcon() {
    if (showBackIcon ?? true) {
      return Icon(Icons.keyboard_arrow_left_rounded, color: AppColors.primaryColor);
    }
    return const SizedBox.shrink();
  }

  /// Builds the title text with proper styling.
  ///
  /// Returns a Text widget with the title
  Widget _buildTitleText() {
    return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal));
  }
}
