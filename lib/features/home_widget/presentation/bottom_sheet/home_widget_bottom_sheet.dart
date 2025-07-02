import 'package:app_minimizer/app_minimizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';

class HomeWidgetBottomSheet extends StatelessWidget {
  const HomeWidgetBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18),
      decoration: Utils.bottomSheetDecoration(ignoreCorners: true),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          SurelineButton(
            disableVerticalPadding: true,
            text: 'Install widget',
            onPressed: () {
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
                          },
                        ),
                      ],
                    ),
              );
            },
          ),
          Spacer(),
        ],
      ),
    );
  }
}
