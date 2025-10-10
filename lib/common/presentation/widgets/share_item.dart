import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class ShareItem extends StatelessWidget {
  final String? imageAsset;
  final IconData? icon;
  final String label;
  final VoidCallback? onPressed;

  const ShareItem({
    super.key,
    this.imageAsset,
    required this.label,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: onPressed,
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imageAsset != null) ...[
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(48),
                  ),
                  child: Image.asset(imageAsset!, width: 36, height: 36),
                ),
              ] else ...[
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(48),
                  ),
                  child: Center(child: Icon(icon, size: 20)),
                ),
              ],
              SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
