import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/theme/app_colors.dart';

class PracticeAppreciationDialog extends StatelessWidget {
  const PracticeAppreciationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close_rounded,
                  size: 20,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(width: 100, height: 100, child: Placeholder()),
            SizedBox(height: 40),
            Text(
              'Great job!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Come back soon - consistency is the key to unlocking the benefits of quotes',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 20),
            SurelineButton(
              text: 'Done',
              onPressed: () {
                Navigator.of(context).pop();
              },
              disableVerticalPadding: true,
              disableHorizontalPadding: true,
            ),
          ],
        ),
      ),
    );
  }
}
