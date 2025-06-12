import 'package:app_minimizer/app_minimizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/theme/app_colors.dart';

class CollectionsBottomSheet extends StatelessWidget {
  const CollectionsBottomSheet({super.key});

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
              'My collections',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  SizedBox(width: 250, height: 250, child: Placeholder()),
                  OnboardingHeading(
                    title: 'You don\'t have any collections yet',
                    subTitle:
                        'Create collections to group quotes you want to save together, like \'Morning motivations\' or \'Beat my fear\'',
                    disableMargins: true,
                  ),
                ],
              ),
            ),
            Spacer(),
            Spacer(),
            SurelineButton(
              disableVerticalPadding: true,
              text: 'Create collection',
              onPressed: () {

              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
