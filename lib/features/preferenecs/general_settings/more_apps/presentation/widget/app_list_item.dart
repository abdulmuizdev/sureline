import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class AppListItem extends StatelessWidget {
  final bool? isFirst;
  final bool? isLast;
  final VoidCallback onPressed;

  const AppListItem({super.key, this.isFirst, this.isLast, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular((isFirst ?? false) ? 10 : 0),
            topRight: Radius.circular((isFirst ?? false) ? 10 : 0),
            bottomLeft: Radius.circular((isLast ?? false) ? 10 : 0),
            bottomRight: Radius.circular((isLast ?? false) ? 10 : 0),
          ),
          border:
              (!(isLast ?? false))
                  ? Border(
                    bottom: BorderSide(
                      color: AppColors.primaryColor.withValues(alpha: 0.3),
                      width: 0.5,
                    ),
                  )
                  : null,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/images/carmaai.png', width: 40, height: 40),
            ),
            SizedBox(width: 14),
            Text(
              'Carma AI',
              style: TextStyle(
                fontSize: 20,
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
