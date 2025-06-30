import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:permission_handler/permission_handler.dart' as AppSettings;
import 'package:share_plus/share_plus.dart';
import 'package:sureline/features/general_settings/help/presentation/help_bottom_sheet.dart';
import 'package:sureline/features/general_settings/streak/presentation/pages/streak_setting_bottom_sheet.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/common/presentation/widgets/settings_list_item.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/general_settings/author_preferences/presentation/pages/author_pref_bottom_sheet.dart';
import 'package:sureline/common/presentation/widgets/heading.dart';
import 'package:sureline/features/general_settings/default/presentation/widget/info_copy.dart';
import 'package:sureline/features/general_settings/gender_identity/presentation/pages/gender_identity_bottom_sheet.dart';
import 'package:sureline/features/general_settings/muted_content/presentation/bottom_sheets/muted_content_bottom_sheet.dart';
import 'package:sureline/features/general_settings/more_apps/presentation/pages/more_apps_bottom_sheet.dart';
import 'package:sureline/features/general_settings/name/presentation/name_bottom_sheet.dart';
import 'package:sureline/features/general_settings/sign_in/presentation/pages/sign_in_bottom_sheet.dart';
import 'package:sureline/features/general_settings/sound/presentation/bottom_sheet/sound_bottom_sheet.dart';
import 'package:sureline/features/general_settings/voice/presentation/pages/voice_bottom_sheet.dart';
import 'package:sureline/features/manage_subscription/presentation/bottom_sheet/manage_subscription_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sureline/features/general_settings/vote_on_next_feature/presentation/vote_on_next_feature_bottom_sheet.dart';

class GeneralSettingsBottomSheet extends StatelessWidget {
  const GeneralSettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, top: 18, right: 18),
      decoration: Utils.bottomSheetDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SurelineBackButton(title: 'Sureline'),
          SizedBox(height: 27),
          Text(
            'Settings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 15),
                        Heading(text: 'PREMIUM'),
                        SizedBox(height: 10),
                        SettingsListItem(
                          useDarkHover: true,
                          title: 'Manage subscription',
                          icon: CupertinoIcons.creditcard,
                          isFirst: true,
                          isLast: true,
                          onPressed: () {
                            showModalBottomSheet(
                              useSafeArea: true,
                              isScrollControlled: true,
                              context: context,
                              builder:
                                  (context) => ManageSubscriptionBottomSheet(),
                            );
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
                            showModalBottomSheet(
                              useSafeArea: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => VoiceBottomSheet(),
                            );
                          },
                        ),
                        SettingsListItem(
                          useDarkHover: true,
                          title: 'Author preferences',
                          icon: Icons.menu_rounded,
                          onPressed: () {
                            showModalBottomSheet(
                              useSafeArea: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => AuthorPrefBottomSheet(),
                            );
                          },
                        ),
                        SettingsListItem(
                          useDarkHover: true,
                          title: 'Muted content',
                          icon: CupertinoIcons.volume_off,
                          onPressed: () {
                            print('muted contrent clicked');
                            showModalBottomSheet(
                              useSafeArea: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => MutedContentBottomSheet(),
                            );
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
                            showModalBottomSheet(
                              useSafeArea: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => NameBottomSheet(),
                            );
                          },
                        ),
                        SettingsListItem(
                          useDarkHover: true,
                          title: 'Sound',
                          icon: CupertinoIcons.volume_up,
                          onPressed: () {
                            showModalBottomSheet(
                              useSafeArea: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => SoundBottomSheet(),
                            );
                          },
                        ),
                        SettingsListItem(
                          useDarkHover: true,
                          title: 'Streak',
                          icon: Icons.add,
                          isLast: true,
                          onPressed: () {
                            showModalBottomSheet(
                              useSafeArea: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => StreakSettingBottomSheet(),
                            );
                          },
                        ),

                        SizedBox(height: 22),
                        Heading(text: 'ACCOUNT'),
                        SizedBox(height: 15),
                        SettingsListItem(
                          useDarkHover: true,
                          title: 'Sign in',
                          icon: CupertinoIcons.person,
                          isFirst: true,
                          isLast: true,
                          onPressed: () {
                            showModalBottomSheet(
                              useSafeArea: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => SignInBottomSheet(),
                            );
                          },
                        ),

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
                                text:
                                    'Hey! Check this app out: https://sureline.app',
                              ),
                            );
                          },
                        ),
                        SettingsListItem(
                          useDarkHover: true,
                          title: 'More by Abdul Muiz',
                          icon: Icons.add,
                          onPressed: () {
                            showModalBottomSheet(
                              useSafeArea: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => MoreAppsBottomSheet(),
                            );
                          },
                        ),
                        SettingsListItem(
                          useDarkHover: true,
                          title: 'Leave a review',
                          icon: Icons.rate_review_outlined,
                          hideArrow: true,
                          onPressed: () {
                            InAppReview.instance.isAvailable().then((
                              isAvailable,
                            ) {
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
                          onPressed:
                              () => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                useSafeArea: true,
                                builder:
                                    (context) => VoteOnNextFeatureBottomSheet(),
                              ),
                        ),

                        SizedBox(height: 22),
                        Heading(text: 'HELP'),
                        SizedBox(height: 15),
                        SettingsListItem(
                          useDarkHover: true,
                          title: 'Help',
                          icon: Icons.help_outline_rounded,
                          isFirst: true,
                          isLast: true,
                          hideArrow: true,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HelpBottomSheet(),
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 22),
                        Heading(text: 'FOLLOW US'),
                        SizedBox(height: 15),
                        SettingsListItem(
                          useDarkHover: true,
                          title: 'Instagram',
                          imageAsset: 'assets/images/instagram.png',
                          isFirst: true,
                          hideArrow: true,
                          onPressed: () async {
                            await openInstagramProfile('sure.line96');
                          },
                        ),
                        SettingsListItem(
                          useDarkHover: true,
                          title: 'TikTok',
                          imageAsset: 'assets/images/tiktok.png',
                          hideArrow: true,
                          onPressed: () async {
                            await openTikTokProfile('sureline96');
                          },
                        ),

                        // SettingsListItem(
                        //   useDarkHover: true,
                        //   title: 'Facebook',
                        //   imageAsset: 'assets/images/facebook.png',
                        //   hideArrow: true,
                        //   onPressed: () async {
                        //     await openFacebookProfile('abdulmuiz.dev_');
                        //   },
                        // ),
                        // SettingsListItem(
                        //   useDarkHover: true,
                        //   title: 'Pinterest',
                        //   icon: Icons.add,
                        //   hideArrow: true,
                        // ),
                        // SettingsListItem(
                        //   useDarkHover: true,
                        //   title: 'X (formerly Twitter)',
                        //   icon: Icons.add,
                        //   isLast: true,
                        //   hideArrow: true,
                        //   onPressed: () async {
                        //     await openXProfile('abdulmuiz.dev_');
                        //   },
                        // ),
                        SizedBox(height: 22),
                        Heading(text: 'OTHER'),
                        SizedBox(height: 15),
                        SettingsListItem(
                          useDarkHover: true,
                          title: 'Privacy Policy',
                          isFirst: true,
                          hideArrow: true,
                        ),
                        SettingsListItem(
                          useDarkHover: true,
                          title: 'Terms and Conditions',
                          hideArrow: true,
                          isLast: true,
                        ),
                        SizedBox(height: 20),
                        InfoCopy(),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openInstagramProfile(String username) async {
    final nativeUrl = Uri.parse("instagram://user?username=$username");
    final webUrl = Uri.parse("https://instagram.com/$username");

    if (await canLaunchUrl(nativeUrl)) {
      debugPrint('opening external app');
      await launchUrl(nativeUrl);
    } else {
      // Fallback to web browser
      debugPrint('opening browser');
      await launchUrl(
        webUrl,
        mode: LaunchMode.inAppWebView, // or LaunchMode.externalApplication
      );
    }
  }

  Future<void> openTikTokProfile(String username) async {
    final nativeUrl = Uri.parse("tiktok://user?username=$username");
    final webUrl = Uri.parse("https://tiktok.com/$username");

    if (await canLaunchUrl(nativeUrl)) {
      debugPrint('opening external app');
      await launchUrl(nativeUrl);
    } else {
      // Fallback to web browser
      debugPrint('opening browser');
      await launchUrl(webUrl, mode: LaunchMode.inAppWebView);
    }
  }

  Future<void> openFacebookProfile(String username) async {
    final nativeUrl = Uri.parse(
      "fb://facewebmodal/f?href=https://www.facebook.com/$username",
    );
    final webUrl = Uri.parse("https://facebook.com.com/$username");

    if (await canLaunchUrl(nativeUrl)) {
      debugPrint('opening external app');
      await launchUrl(nativeUrl);
    } else {
      // Fallback to web browser
      debugPrint('opening browser');
      await launchUrl(
        webUrl,
        mode: LaunchMode.inAppWebView, // or LaunchMode.externalApplication
      );
    }
  }

  Future<void> openXProfile(String username) async {
    final nativeUrl = Uri.parse("twitter://user?screen_name=$username");
    final webUrl = Uri.parse("https://twitter.com/$username");

    if (await canLaunchUrl(nativeUrl)) {
      await launchUrl(nativeUrl);
    } else {
      // Fallback to web browser
      await launchUrl(
        webUrl,
        mode: LaunchMode.inAppWebView, // or LaunchMode.externalApplication
      );
    }
  }
}
