import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class NotificationSelector extends StatefulWidget {
  final Function(int value) onValueChanged;
  const NotificationSelector({super.key, required this.onValueChanged});


  @override
  State<NotificationSelector> createState() => _NotificationSelectorState();
}

class _NotificationSelectorState extends State<NotificationSelector> {
  int _count = 10;
  bool _isMinusEnabled = true;
  bool _isPlusEnabled = true;

  // Function to handle increment and decrement logic
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
        decoration: BoxDecoration(
          color: AppColors.white2,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'How many',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryColor,
              ),
            ),
            Row(
              children: [
                adjustmentButton(
                  _isMinusEnabled,
                  Icons.remove_rounded,
                      () => _adjustCount(false),
                ),
                const SizedBox(width: 30),
                SizedBox(
                  width: 35,
                  child: Text(
                    '${_count}x',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                adjustmentButton(
                  _isPlusEnabled,
                  Icons.add_rounded,
                      () => _adjustCount(true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget adjustmentButton(bool isEnabled, IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        width: 37,
        height: 37,
        decoration: BoxDecoration(
          color: isEnabled
              ? AppColors.primaryColor
              : AppColors.primaryColor.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.pureWhite),
      ),
    );
  }
}
