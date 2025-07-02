import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sureline/core/theme/app_colors.dart';

class InfoCopy extends StatefulWidget {
  const InfoCopy({super.key});

  @override
  State<InfoCopy> createState() => _InfoCopyState();
}

class _InfoCopyState extends State<InfoCopy> {
  bool _showCopied = false;
  String _version = '';

  @override
  void initState() {
    super.initState();
    _getAppVersion().then((value) {
      debugPrint(value);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          setState(() {
            _version = value;
          });
        }
      });
    });
  }

  void _handleCopy() {
    setState(() {
      _showCopied = true;
    });

    // Hide the message after 1 second
    Future.delayed(Duration(seconds: 1), () {
      if (context.mounted) {
        setState(() {
          _showCopied = false;
        });
      }
    });

    // Optionally copy to clipboard
    Clipboard.setData(ClipboardData(text: '12345678-AAAA-AAAA-A...'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Sureline app - version ${_version}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  // SizedBox(height: 10),
                  // Text(
                  //   'User ID: 12345678-AAAA-AAAA-A...',
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.normal,
                  //     color: AppColors.primaryColor,
                  //   ),
                  // ),
                ],
              ),
              Container(
                width: 1,
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 10),
                color: AppColors.primaryColor.withOpacity(0.3),
              ),
              GestureDetector(
                onTap: _handleCopy,
                child: Icon(
                  Icons.copy_rounded,
                  color: AppColors.primaryColor,
                  size: 22,
                ),
              ),
            ],
          ),
          IgnorePointer(
            ignoring: !_showCopied,
            child: AnimatedOpacity(
              opacity: _showCopied ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Text copied!',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }
}
