import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/common/presentation/widgets/sureline_check_box.dart';

class SurveySelector extends StatelessWidget {
  final String text;
  final bool isChecked;
  final String? imageAsset;

  const SurveySelector({
    super.key,
    required this.text,
    required this.isChecked,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 7),
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.white, width: 1.5),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (imageAsset != null) ...[
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset(imageAsset!),
                      ),
                      SizedBox(width: 15),
                    ],
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                SurelineCheckBox(isChecked: isChecked),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
