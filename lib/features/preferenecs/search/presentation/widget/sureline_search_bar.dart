import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class SurelineSearchBar extends StatelessWidget {
  final TextEditingController controller;
  const SurelineSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 8,),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                  color: AppColors.primaryColor
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(
                    color: AppColors.primaryColor.withValues(alpha: 0.4)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
