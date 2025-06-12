import 'package:app_minimizer/app_minimizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/theme/app_colors.dart';

class HomeWidgetBottomSheet extends StatelessWidget {
  const HomeWidgetBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.keyboard_arrow_left_rounded,
                    color: AppColors.primaryColor,
                  ),
                  Text(
                    'Sureline',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 27),
            Text(
              'Widgets',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/home_widget.png',
                    width: 313,
                    height: 412,
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 33),
                        child: Text(
                          'Add a widget to your Home Screen',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: AppColors.primaryColor,
                  ),
                ),
                Expanded(
                  child: Text(
                    'On your phone\'s Home Screen, touch and hold an empty area until the apps jiggle',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 17),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2. ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: AppColors.primaryColor,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Tap the Edit button in the upper corner to add the widget',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Spacer(),
            SurelineButton(disableVerticalPadding: true, text: 'Install widget', onPressed: () {
              showCupertinoDialog(
                context: context,
                builder:
                    (_) => CupertinoAlertDialog(
                  title: Text(
                    '\'Sureline\' would like to open your Home Screen',
                  ),
                  content: Text(
                    'The app will close and your phone\'s Home Screen will open.',
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: Text(
                        'Open',
                        style: TextStyle(
                          color: Color(0xFF007AFF),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        FlutterAppMinimizer.minimize();
                      } ,
                    ),
                  ],
                ),
              );
            }),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
