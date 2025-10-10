import 'package:flutter/material.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/theme/app_colors.dart';

class Watermark extends StatelessWidget {
  final double? height;
  final Color? overrideColor;
  const Watermark({super.key, this.height, this.overrideColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 25,
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.pureWhite.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.pureWhite,
          width: 1,
          strokeAlign: BorderSide.strokeAlignCenter,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset('assets/images/one.png'),
            ),
            const SizedBox(width: 4),
            Text(
              'Sureline',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: overrideColor ?? App.themeEntity.textDecorEntity.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
