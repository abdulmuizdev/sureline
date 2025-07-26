import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/preferenecs/general_settings/more_apps/presentation/widget/app_list_item.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreAppsBottomSheet extends StatelessWidget {
  const MoreAppsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18),
      decoration: Utils.bottomSheetDecoration(ignoreCorners: true),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Abdul Muiz',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 40),
          Text(
            'CHECK OUT MORE APPS',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 60),
          AppListItem(
            isFirst: true,
            isLast: false,
            title: 'Reveo AI',
            image: 'assets/images/reveo.png',
            onPressed: () {
              _openInAppBrowser('https://apps.apple.com/pk/app/reveo-ai/id6748625301');
            },
          ),
          AppListItem(
            isFirst: false,
            isLast: true,
            title: 'Carma AI',
            image: 'assets/images/carmaai.png',
            onPressed: () {
              _openInAppBrowser('https://apps.apple.com/us/app/carma-ai/id6741025552');
            },
          ),
        ],
      ),
    );
  }

  void _openInAppBrowser(String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.inAppWebView, // Uses SafariViewController on iOS
        );
      } else {
        print('Could not launch $url');
      }
    } catch (e) {
      print('Could not launch $urlString');
    }
  }
}
