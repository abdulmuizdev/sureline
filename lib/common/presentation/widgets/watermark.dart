import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class Watermark extends StatelessWidget {
  final double? height;
  const Watermark({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: height ?? 25,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset('assets/images/one.png'),
            ),
            SizedBox(width: 4),
            Text(
              'Sureline.app',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
