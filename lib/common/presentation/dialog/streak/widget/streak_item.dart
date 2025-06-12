import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class StreakItem extends StatelessWidget {
  final bool isChecked;
  final bool? isGift;
  final bool? isMissed;
  final String day;
  final bool? animateSelection;

  const StreakItem({super.key, required this.isChecked, this.isGift,
    this.isMissed,
    this.animateSelection,
  required this.day});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(day, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        SizedBox(height: 11),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color:
                (isChecked)
                    ? null
                    : AppColors.primaryColor.withValues(alpha: 0.1),
            gradient:
                (isChecked)
                    ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.pink,
                        AppColors.pink.withValues(alpha: 0.5),
                      ],
                    )
                    : null,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              if (isChecked) ...[
                Center(
                  child: Icon(Icons.check_rounded, color: AppColors.white, size: 15,),
                ),
              ],
              if (!isChecked && ( (isMissed ?? false) || (isGift ?? false) )) ...[
                Center(
                  child: Icon(
                    (isMissed ?? false) ? Icons.ac_unit_rounded : Icons.card_giftcard_rounded,
                    size: 15,
                    color: AppColors.primaryColor.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
