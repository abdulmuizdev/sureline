import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class SurelineBackButton extends StatelessWidget {
  final String title;
  final bool? showBackIcon;
  const SurelineBackButton({super.key, required this.title, this.showBackIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Row(
        children: [
          if (showBackIcon ?? true) ...[
            Icon(
              Icons.keyboard_arrow_left_rounded,
              color: AppColors.primaryColor,
            ),
          ],
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
