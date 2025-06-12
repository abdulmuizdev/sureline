import 'package:app_minimizer/app_minimizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/watch/presentation/widget/set_as_watch_face_button.dart';

class WatchBottomSheet extends StatelessWidget {
  const WatchBottomSheet({super.key});

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
              'Watch',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Sureline face',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 107,
                  height: 128,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Placeholder(),
                  ),
                ),
                SizedBox(width: 30),
                SetAsWatchFaceButton(onPressed: () {}),
                SizedBox(width: 30),
                SizedBox(width: 30),
                Icon(
                  Icons.ios_share_rounded,
                  color: AppColors.primaryColor,
                  size: 27,
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'You can also add Sureline complications to the face you\'re using on your Watch',
              style: TextStyle(
                fontSize: 16,
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
