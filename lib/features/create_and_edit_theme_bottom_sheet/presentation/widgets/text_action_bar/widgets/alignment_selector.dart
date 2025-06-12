import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class AlignmentSelector extends StatelessWidget {
  final CrossAxisAlignment alignment;
  const AlignmentSelector({super.key,  required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: alignment,
      children: [
        Container(
          width: 10,
          height: 5,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(height: 3,),
        Container(
          width: 15,
          height: 5,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
