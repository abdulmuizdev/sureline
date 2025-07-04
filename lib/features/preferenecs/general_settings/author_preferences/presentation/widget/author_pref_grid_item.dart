import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class AuthorPrefGridItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final bool isLocked;
  final VoidCallback onPressed;

  const AuthorPrefGridItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.isLocked,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          (isLocked)
              ? () {
                print('show paywall');
              }
              : onPressed,
      child: Container(
        decoration: BoxDecoration(
          border:
              isSelected
                  ? null
                  : Border.all(color: AppColors.primaryColor, width: 1),
          color: isSelected ? AppColors.peach : AppColors.pureWhite,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color:
                      isSelected
                          ? AppColors.primaryColor
                          : AppColors.primaryColor.withValues(alpha: 0.7),
                ),
              ),
            ),
            if (isLocked)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Icon(
                    CupertinoIcons.lock_fill,
                    color: AppColors.primaryColor.withValues(alpha: 0.5),
                    size: 15,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
