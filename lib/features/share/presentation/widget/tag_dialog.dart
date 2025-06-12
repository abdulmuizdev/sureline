import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/theme/app_colors.dart';

class TagDialog extends StatelessWidget {
  final VoidCallback onDonePressed;
  const TagDialog({super.key, required this.onDonePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: onDonePressed,
                icon: Icon(
                  Icons.close_rounded,
                  size: 20,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset('assets/images/instagram.png'),
            ),
            SizedBox(height: 40),
            Text(
              '@sure.line96',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Dont\'t forget to tag us',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Text and hastags are ready to be pasted in your caption.',
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
              onPressed: onDonePressed,
              disableVerticalPadding: true,
              disableHorizontalPadding: true,
            ),
          ],
        ),
      ),
    );
  }
}
