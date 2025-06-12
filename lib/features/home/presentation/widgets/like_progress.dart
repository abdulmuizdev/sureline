import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/home/presentation/widgets/step_progress_bar.dart';

class LikeProgress extends StatelessWidget {
  final VoidCallback? onPressed;
  final int likeCount;
  final int likeGoal;
  const LikeProgress({super.key, this.onPressed, required this.likeCount,
  required this.likeGoal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 174,
        height: 30,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.favorite_outline_rounded,
                color: AppColors.primaryColor,
                size: 17,
              ),
              Text(
                '$likeCount/$likeGoal',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryColor,
                ),
              ),
              StepProgressBar(value: likeCount, maxValue: likeGoal,)
              // Container(
              //   width: 90,
              //   height: 6,
              //   decoration: BoxDecoration(
              //     color: AppColors.primaryColor.withValues(alpha: 0.3),
              //     borderRadius: BorderRadius.circular(14)
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
