import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

/// Custom search bar widget for the Sureline app.
///
/// This widget provides a premium search input experience with custom
/// styling that matches the app's design language. It features a
/// subtle background color, rounded corners, and consistent typography
/// for an intuitive search experience.
///
/// Key Features:
/// - Custom styled text input field
/// - Premium visual design with rounded corners
/// - Consistent theming with app colors
/// - Responsive width adaptation
/// - Intuitive placeholder text
/// - Smooth text input experience
///
/// Design Elements:
/// - Light primary color background (10% opacity)
/// - 8px border radius for modern look
/// - Consistent text styling with primary color
/// - Subtle placeholder text styling
/// - Full-width responsive design
///
/// Visual Hierarchy:
/// - Clear visual distinction from background
/// - Consistent with app's color scheme
/// - Accessible text contrast
/// - Professional input field appearance
///
/// Usage:
/// ```dart
/// SurelineSearchBar(
///   controller: searchController,
/// )
/// ```
class SurelineSearchBar extends StatelessWidget {
  /// The text editing controller for the search input.
  ///
  /// This controller manages the text input state and provides
  /// access to the current search query text.
  final TextEditingController controller;

  /// Creates a new SurelineSearchBar instance.
  const SurelineSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // Light primary color background for subtle distinction
        color: AppColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Left padding for text field
          const SizedBox(width: 8),
          // Expandable text input field
          Expanded(
            child: TextField(
              controller: controller,
              // Primary color text for consistency
              style: const TextStyle(color: AppColors.primaryColor),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                // Subtle placeholder text styling
                hintStyle: TextStyle(color: AppColors.primaryColor.withValues(alpha: 0.4)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
