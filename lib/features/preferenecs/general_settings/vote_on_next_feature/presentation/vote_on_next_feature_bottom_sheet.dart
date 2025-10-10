import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/constants/secrets.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VoteOnNextFeatureBottomSheet extends StatefulWidget {
  const VoteOnNextFeatureBottomSheet({super.key});

  @override
  State<VoteOnNextFeatureBottomSheet> createState() => _VoteOnNextFeatureBottomSheetState();
}

class _VoteOnNextFeatureBottomSheetState extends State<VoteOnNextFeatureBottomSheet> {
  WebViewController _controller = WebViewController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    final cannyToken = await _generateCannyToken();

    _controller =
        WebViewController()
          ..enableZoom(false)
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (url) {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          )
          ..loadRequest(
            Uri.parse(
              'https://webview.canny.io?boardToken=${Secrets.cannyBoardToken}&ssoToken=$cannyToken',
            ),
          );
  }

  Future<String> _generateCannyToken() async {
    // Get device identifier using device_info_plus
    final deviceInfo = DeviceInfoPlugin();
    String deviceId;

    try {
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? 'unknown-device';
      } else {
        final androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
      }
    } catch (e) {
      debugPrint('Error getting device info: $e');
      deviceId = 'unknown-device';
    }

    // Get user name from shared preferences
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString(SP.name);
    final displayName = (userName != null && userName.isNotEmpty) ? userName : 'Sureline User';

    // User data for Canny token generation
    final Map<String, dynamic> userData = {
      'avatarURL': null, // optional, but preferred
      'email': '$deviceId@abdulmuiz.dev', // Use device ID as email
      'id': deviceId, // Use device ID as user ID
      'name': displayName, // Use name from shared preferences or default
    };

    // Private key for JWT signing
    const String privateKey = Secrets.cannyPrivateKey;

    try {
      // Create JWT payload
      final Map<String, dynamic> payload = {
        'email': userData['email'],
        'id': userData['id'],
        'name': userData['name'],
        'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      };

      // Create JWT header
      final Map<String, dynamic> header = {'alg': 'HS256', 'typ': 'JWT'};

      // Encode header and payload to base64url
      final String encodedHeader = _base64UrlEncode(utf8.encode(json.encode(header)));
      final String encodedPayload = _base64UrlEncode(utf8.encode(json.encode(payload)));

      // Create signature input
      final String signatureInput = '$encodedHeader.$encodedPayload';

      // Create HMAC-SHA256 signature
      final Hmac hmac = Hmac(sha256, utf8.encode(privateKey));
      final Digest digest = hmac.convert(utf8.encode(signatureInput));
      final String signature = _base64UrlEncode(digest.bytes);

      // Combine to create JWT token
      return '$signatureInput.$signature';
    } catch (e) {
      debugPrint('Error generating Canny token: $e');
      return '';
    }
  }

  String _base64UrlEncode(List<int> bytes) {
    return base64Url.encode(bytes).replaceAll('=', '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18),
      decoration: Utils.bottomSheetDecoration(ignoreCorners: true),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vote on next feature',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
              Expanded(child: WebViewWidget(controller: _controller)),
            ],
          ),
          if (_isLoading) ...[Center(child: CircularProgressIndicator())],
        ],
      ),
    );
  }
}
