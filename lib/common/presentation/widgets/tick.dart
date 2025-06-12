import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class Tick extends StatelessWidget {
  const Tick({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: AppColors.primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(Icons.check_outlined, color: AppColors.white, size: 13),
      ),
    );
  }
}
