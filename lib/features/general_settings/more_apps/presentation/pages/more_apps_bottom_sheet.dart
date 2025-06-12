import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/general_settings/more_apps/presentation/widget/app_list_item.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreAppsBottomSheet extends StatelessWidget {
  const MoreAppsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: Utils.bottomSheetDecoration(),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SurelineBackButton(title: 'Settings'),
          SizedBox(height: 27),
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
          ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return AppListItem(
                isFirst: index == 0,
                isLast: index == 1-1,
                onPressed: (){
                  _openInAppBrowser();
                },
              );
            },
          ),
        ],
      ),
    );
  }
  void _openInAppBrowser() async {
    final Uri url = Uri.parse('https://apps.apple.com/us/app/carma-ai/id6741025552');
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView, // Uses SafariViewController on iOS
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
