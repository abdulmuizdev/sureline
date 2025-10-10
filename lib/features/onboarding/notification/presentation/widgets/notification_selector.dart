import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

/// Widget for selecting the number of notifications per day.
/// This component provides an interactive interface for users to choose
/// how many notifications they want to receive, with increment/decrement controls.
///
/// The widget includes visual feedback for button states and enforces
/// minimum and maximum limits for notification frequency.
class NotificationSelector extends StatelessWidget {
  /// Callback function triggered when the notification count changes.
  /// Provides the new count value to the parent component.
  final Function(int value) onValueChanged;

  final int count;

  const NotificationSelector({super.key, required this.onValueChanged, this.count = 10});

  /// Handles increment and decrement logic for the notification count.
  /// Updates button states and notifies the parent of changes.
  ///
  /// [isIncrement] - Whether to increment (true) or decrement (false) the count
  void _adjustCount(bool isIncrement) {
    if (isIncrement) {
      if (count < 20) {
        onValueChanged(count + 1);
      }
    } else {
      if (count > 0) {
        onValueChanged(count - 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(color: AppColors.white2, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'How many',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryColor,
              ),
            ),
            Row(
              children: [
                _buildAdjustmentButton(
                  isEnabled: count > 0,
                  icon: Icons.remove_rounded,
                  onPressed: () => _adjustCount(false),
                ),
                const SizedBox(width: 30),
                SizedBox(
                  width: 35,
                  child: Text(
                    '${count}x',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                _buildAdjustmentButton(
                  isEnabled: count < 20,
                  icon: Icons.add_rounded,
                  onPressed: () => _adjustCount(true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds an adjustment button with proper styling and state handling.
  ///
  /// [isEnabled] - Whether the button should be interactive
  /// [icon] - The icon to display on the button
  /// [onPressed] - Callback function when the button is pressed
  Widget _buildAdjustmentButton({
    required bool isEnabled,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        width: 37,
        height: 37,
        decoration: BoxDecoration(
          color: isEnabled ? AppColors.primaryColor : AppColors.primaryColor.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.pureWhite),
      ),
    );
  }
}
