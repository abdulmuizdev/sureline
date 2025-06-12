import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class HistoryListItem extends StatelessWidget {
  const HistoryListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.pureWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'I am building apps',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 20, height: 20, child: Placeholder()),
                SizedBox(width: 15,),
                SizedBox(width: 20, height: 20, child: Placeholder()),
                SizedBox(width: 15,),
                SizedBox(width: 20, height: 20, child: Placeholder()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
