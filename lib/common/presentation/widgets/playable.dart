import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class Playable extends StatelessWidget {
  const Playable({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeWidth: 1.5,
      dashPattern: [3,3],
      color: AppColors.white,
      borderType: BorderType.Circle,
      child: SizedBox(
        width: 18,
        height: 18,
        child: Center(
          child: Icon(
            Icons.play_arrow_rounded,
            color: AppColors.white,
            size: 15,
          ),
        ),
      ),
    );
  }
}
