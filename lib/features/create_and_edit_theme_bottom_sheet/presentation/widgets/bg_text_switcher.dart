import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class BgTextSwitcher extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelectionChanged;

  const BgTextSwitcher({
    super.key,
    required this.onSelectionChanged,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () => onSelectionChanged(0),
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: selectedIndex == 0
                      ? AppColors.primaryColor.withAlpha(30)
                      : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    'Background',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () => onSelectionChanged(1),
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: selectedIndex == 1
                      ? AppColors.primaryColor.withAlpha(30)
                      : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    'Text',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
