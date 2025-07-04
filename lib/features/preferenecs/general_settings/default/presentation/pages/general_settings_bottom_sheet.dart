import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:permission_handler/permission_handler.dart' as AppSettings;
import 'package:share_plus/share_plus.dart';
import 'package:sureline/common/presentation/widgets/heading.dart';
import 'package:sureline/common/presentation/widgets/settings_list_item.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/presentation/pages/author_pref_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/default/presentation/widget/info_copy.dart';
import 'package:sureline/features/preferenecs/general_settings/help/presentation/help_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/more_apps/presentation/pages/more_apps_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/muted_content/presentation/bottom_sheets/muted_content_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/name/presentation/name_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/sign_in/presentation/pages/sign_in_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/presentation/bottom_sheet/sound_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/streak/presentation/pages/streak_setting_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/presentation/pages/voice_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/vote_on_next_feature/presentation/vote_on_next_feature_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/manage_subscription/presentation/bottom_sheet/manage_subscription_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneralSettingsBottomSheet extends StatelessWidget {
  const GeneralSettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18),
      color: AppColors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 25),
                  Heading(text: 'PREMIUM'),
                  SizedBox(height: 10),
                  SettingsListItem(
                    useDarkHover: true,
                    title: 'Manage subscription',
                    icon: CupertinoIcons.creditcard,
                    isFirst: true,
                    isLast: true,
                    onPressed: () {
                      context.push('/general-settings/manage-subscription');
                    },
                  ),
                  SizedBox(height: 22),
                  Heading(text: 'MAKE IT YOURS'),
                  SizedBox(height: 15),
                  SettingsListItem(
                    useDarkHover: true,
                    title: 'Voice',
                    icon: CupertinoIcons.mic,
                    isFirst: true,
                    onPressed: () {
                      context.push('/general-settings/voice');
                    },
                  ),
                  SettingsListItem(
                    useDarkHover: true,
                    title: 'Author preferences',
                    icon: Icons.menu_rounded,
                    onPressed: () {
                      context.push('/general-settings/author-preferences');
                    },
                  ),
                  SettingsListItem(
                    useDarkHover: true,
                    title: 'Muted content',
                    icon: CupertinoIcons.volume_off,
                    onPressed: () {
                      context.push('/general-settings/muted-content');
                    },
                  ),
                  // SettingsListItem(
                  //   useDarkHover: true,
                  //   title: 'Gender identity',
                  //   icon: Icons.male_rounded,
                  //   onPressed: () {
                  //     showModalBottomSheet(
                  //       useSafeArea: true,
                  //       isScrollControlled: true,
                  //       context: context,
                  //       builder: (context) => GenderIdentityBottomSheet(),
                  //     );
                  //   },
                  // ),
                  SettingsListItem(
                    useDarkHover: true,
                    title: 'Language',
                    icon: Icons.language_rounded,
                    onPressed: () async {
                      await AppSettings.openAppSettings();
                    },
                  ),
                  SettingsListItem(
                    useDarkHover: true,
                    title: 'Name',
                    icon: CupertinoIcons.person,
                    onPressed: () {
                      context.push('/general-settings/name');
                    },
                  ),
                  SettingsListItem(
                    useDarkHover: true,
                    title: 'Sound',
                    icon: CupertinoIcons.volume_up,
                    onPressed: () {
                      context.push('/general-settings/sound');
                    },
                  ),
                  SettingsListItem(
                    useDarkHover: true,
                    title: 'Streak',
                    icon: Icons.add,
                    isLast: true,
                    onPressed: () {
                      context.push('/general-settings/streak');
                    },
                  ),

                  // SizedBox(height: 22),
                  // Heading(text: 'ACCOUNT'),
                  // SizedBox(height: 15),
                  // SettingsListItem(
                  //   useDarkHover: true,
                  //   title: 'Sign in',
                  //   icon: CupertinoIcons.person,
                  //   isFirst: true,
                  //   isLast: true,
                  //   onPressed: () {
                  //     Navigator.of(context).push(
                  //       CupertinoPageRoute(
                  //         builder: (context) => SignInBottomSheet(),
                  //       ),
                  //     );
                  //   },
                  // ),
                  SizedBox(height: 22),
                  Heading(text: 'SUPPORT UP'),
                  SizedBox(height: 15),
                  SettingsListItem(
                    useDarkHover: true,
                    title: 'Share Sureline',
                    icon: CupertinoIcons.share_up,
                    isFirst: true,
                    hideArrow: true,
                    onPressed: () {
                      SharePlus.instance.share(
                        ShareParams(
                          text: 'Hey! Check this app out: https://sureline.app',
                        ),
                      );
                    },
                  ),
                  SettingsListItem(
                    useDarkHover: true,
                    title: 'More by Abdul Muiz',
                    icon: Icons.add,
                    onPressed: () {
                      context.push('/general-settings/more-apps');
                    },
                  ),
                  SettingsListItem(
                    useDarkHover: true,
                    title: 'Leave a review',
                    icon: Icons.rate_review_outlined,
                    hideArrow: true,
                    onPressed: () {
                      InAppReview.instance.isAvailable().then((isAvailable) {
                        InAppReview.instance.requestReview();
                      });
                    },
                  ),
                  SettingsListItem(
                    useDarkHover: true,
                    title: 'Vote on next feature',
                    icon: CupertinoIcons.star,
                    isLast: true,
                    hideArrow: true,
                    onPressed: () {
                      context.push('/general-settings/vote-on-next-feature');
                    },
                  ),

                  SizedBox(height: 22),
                  Heading(text: 'HELP'),
                  SizedBox(height: 15),
                  SettingsListItem(
                    useDarkHover: true,
                    title: 'Help',
                    icon: CupertinoIcons.question_circle,
                    isFirst: true,
                    onPressed: () {
                      context.push('/general-settings/help');
                    },
                  ),
                  SettingsListItem(
                    useDarkHover: true,
                    title: 'Privacy Policy',
                    icon: CupertinoIcons.lock,
                    hideArrow: true,
                    onPressed: () async {
                      final Uri url = Uri.parse('https://sureline.app/privacy');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                  ),
                  SettingsListItem(
                    useDarkHover: true,
                    title: 'Terms of Service',
                    icon: CupertinoIcons.doc_text,
                    isLast: true,
                    hideArrow: true,
                    onPressed: () async {
                      final Uri url = Uri.parse('https://sureline.app/terms');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
