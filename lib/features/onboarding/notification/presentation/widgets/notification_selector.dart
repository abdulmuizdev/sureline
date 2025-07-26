import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

/// Widget for selecting the number of notifications per day.
/// This component provides an interactive interface for users to choose
/// how many notifications they want to receive, with increment/decrement controls.
///
/// The widget includes visual feedback for button states and enforces
/// minimum and maximum limits for notification frequency.
class NotificationSelector extends StatefulWidget {
  /// Callback function triggered when the notification count changes.
  /// Provides the new count value to the parent component.
  final Function(int value) onValueChanged;

  const NotificationSelector({super.key, required this.onValueChanged});

  @override
  State<NotificationSelector> createState() => _NotificationSelectorState();
}

class _NotificationSelectorState extends State<NotificationSelector> {
  /// Current notification count selected by the user.
  /// Ranges from 0 to 20 with a default of 10.
  int _count = 10;

  /// Whether the minus button is enabled.
  /// Disabled when count reaches the minimum (0).
  bool _isMinusEnabled = true;

  /// Whether the plus button is enabled.
  /// Disabled when count reaches the maximum (20).
  bool _isPlusEnabled = true;

  /// Handles increment and decrement logic for the notification count.
  /// Updates button states and notifies the parent of changes.
  ///
  /// [isIncrement] - Whether to increment (true) or decrement (false) the count
  void _adjustCount(bool isIncrement) {
    setState(() {
      if (isIncrement) {
        if (_count < 20) {
          _count++;
        }
      } else {
        if (_count > 0) {
          _count--;
        }
      }

      // Update button states based on the current count
      _isPlusEnabled = _count < 20;
      _isMinusEnabled = _count > 0;
    });
    widget.onValueChanged(_count);
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
                  _isMinusEnabled,
                  Icons.remove_rounded,
                  () => _adjustCount(false),
                ),
                const SizedBox(width: 30),
                SizedBox(
                  width: 35,
                  child: Text(
                    '${_count}x',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                _buildAdjustmentButton(_isPlusEnabled, Icons.add_rounded, () => _adjustCount(true)),
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
  Widget _buildAdjustmentButton(bool isEnabled, IconData icon, VoidCallback onPressed) {
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
