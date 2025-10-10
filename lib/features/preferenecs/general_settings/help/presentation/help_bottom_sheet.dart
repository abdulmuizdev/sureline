import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpBottomSheet extends StatefulWidget {
  const HelpBottomSheet({super.key});

  @override
  State<HelpBottomSheet> createState() => _HelpBottomSheetState();
}

class _HelpBottomSheetState extends State<HelpBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18),
      decoration: Utils.bottomSheetDecoration(ignoreCorners: true),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Help',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Need help with Sureline?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Get support, find answers to common questions, and learn how to make the most of your Sureline experience.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final Uri url = Uri.parse('https://sureline.tawk.help/');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                'Open Help Center',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
