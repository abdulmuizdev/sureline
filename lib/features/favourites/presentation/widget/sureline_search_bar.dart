import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class SurelineSearchBar extends StatelessWidget {
  const SurelineSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Row(
          children: [
            SizedBox(width: 16, height: 16, child: Placeholder(),),
            SizedBox(width: 7,),
            Text('Search'),
          ],
        ),
      ),
    );
  }
}
