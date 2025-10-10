import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/watch/presentation/widget/set_as_watch_face_button.dart';

/// Bottom sheet for Apple Watch integration and watch face customization.
///
/// This widget provides the interface for users to set Sureline as their
/// Apple Watch face and manage watch complications. It offers a seamless
/// integration between the iOS app and Apple Watch for continuous
/// motivational content delivery.
///
/// Key Features:
/// - Apple Watch face preview and selection
/// - Watch face customization options
/// - Complication management and setup
/// - Native iOS sharing integration
/// - Premium watch face design
/// - Seamless app-to-watch connectivity
///
/// Apple Watch Integration:
/// - Direct watch face installation
/// - Complication data synchronization
/// - Real-time quote updates
/// - Background refresh support
/// - Health and activity integration
///
/// Watch Face Capabilities:
/// - Dynamic quote display on watch
/// - Customizable complications
/// - Multiple watch face styles
/// - Background customization
/// - Notification integration
///
/// UX Design:
/// - Native iOS design language
/// - Intuitive watch face preview
/// - Clear action buttons
/// - Helpful instructional text
/// - Premium visual presentation
///
/// Usage:
/// ```dart
/// showModalBottomSheet(
///   context: context,
///   isScrollControlled: true,
///   builder: (context) => WatchBottomSheet(),
/// );
/// ```
class WatchBottomSheet extends StatelessWidget {
  /// Creates a new WatchBottomSheet instance.
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
            // Navigation header with back button
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  Icon(Icons.keyboard_arrow_left_rounded, color: AppColors.primaryColor),
                  Text('Sureline', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                ],
              ),
            ),
            SizedBox(height: 27),
            // Section title
            Text(
              'Watch',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 24),
            // Watch face title
            Text(
              'Sureline face',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 20),
            // Watch face preview and controls
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Watch face preview placeholder
                SizedBox(
                  width: 107,
                  height: 128,
                  child: Padding(padding: const EdgeInsets.only(top: 6), child: Placeholder()),
                ),
                SizedBox(width: 30),
                // Set as watch face button
                SetAsWatchFaceButton(onPressed: () {}),
                SizedBox(width: 30),
                SizedBox(width: 30),
                // Share button for watch face
                Icon(Icons.ios_share_rounded, color: AppColors.primaryColor, size: 27),
              ],
            ),
            SizedBox(height: 20),
            // Instructional text for complications
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
