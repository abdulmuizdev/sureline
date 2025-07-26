import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sureline/core/libraries/direct_social_share/direct_social_share_schemas.dart';

/// Direct social sharing functionality.
///
/// This class provides methods to share content directly to various social media platforms.
class DirectSocialShare {
  /// Shares content to a specified social media platform.
  ///
  /// Parameters:
  /// - [videoPath]: Path to the video/image file
  /// - [schema]: The social media platform schema
  /// - [appID]: Application ID for the platform
  /// - [isImage]: Whether the content is an image (optional)
  static void share({
    required String videoPath,
    required SocialShareSchema schema,
    required String appID,
    bool? isImage,
  }) {
    try {
      final finalSchema = _getFinalSchema(schema);
      debugPrint("final schema is this");
      debugPrint(finalSchema);
      final targetAppIdentifier = _getTargetAppIdentifier(schema);
      MethodChannel('com.abdulmuiz.sureline/share')
          .invokeMethod('share', {
            'path': videoPath,
            'schema': finalSchema,
            'appID': appID,
            'targetAppIdentifier': targetAppIdentifier,
            'isImage': isImage ?? false,
          })
          .then((result) {
            print(result.toString());
          });
    } catch (e) {
      debugPrint('${e}');
    }
  }

  /// Shares a message with video content.
  ///
  /// Parameters:
  /// - [videoPath]: Path to the video file
  static void shareMessage(String videoPath) {
    try {
      MethodChannel(
        'com.abdulmuiz.sureline/share',
      ).invokeMethod('shareMessage', {'path': videoPath}).then((result) {
        debugPrint(result.toString());
      });
    } catch (e) {
      debugPrint('${e}');
    }
  }

  /// Shares content on TikTok.
  ///
  /// Parameters:
  /// - [path]: Path to the content file
  /// - [isImage]: Whether the content is an image
  static void shareOnTikTok({required String path, required bool isImage}) {
    try {
      MethodChannel(
        'com.abdulmuiz.sureline/share',
      ).invokeMethod('shareTikTok', {'path': path, 'isImage': isImage}).then((result) {
        debugPrint(result.toString());
      });
    } catch (e) {
      debugPrint('${e}');
    }
  }

  /// Shares content on Instagram.
  ///
  /// Parameters:
  /// - [path]: Path to the content file
  /// - [isImage]: Whether the content is an image
  static void shareOnInstagram(String path, bool isImage) {
    try {
      MethodChannel(
        'com.abdulmuiz.sureline/share',
      ).invokeMethod('shareInstagram', {'path': path, 'isImage': isImage}).then((result) {
        debugPrint(result.toString());
      });
    } catch (e) {
      debugPrint('${e}');
    }
  }

  /// Shares content on Facebook.
  ///
  /// Parameters:
  /// - [videoPath]: Path to the video file
  static void shareOnFacebook({required String videoPath}) {
    try {
      MethodChannel(
        'com.abdulmuiz.sureline/share',
      ).invokeMethod('shareFacebook', {'path': videoPath}).then((result) {
        debugPrint(result.toString());
      });
    } catch (e) {
      debugPrint('${e}');
    }
  }

  /// Gets the final schema string for the given social share schema.
  static String _getFinalSchema(SocialShareSchema schema) {
    switch (schema) {
      case SocialShareSchema.facebookReel:
        return 'facebook-reels';
      case SocialShareSchema.facebookStory:
        return 'facebook-stories';
      case SocialShareSchema.instagramReel:
        return 'instagram-reels';
      case SocialShareSchema.instagramStory:
        return 'instagram-stories';
      case SocialShareSchema.facebook:
        return 'fbapi';
    }
  }

  /// Gets the target app identifier for the given social share schema.
  static String _getTargetAppIdentifier(SocialShareSchema schema) {
    switch (schema) {
      case SocialShareSchema.facebookReel:
        return 'facebook';
      case SocialShareSchema.facebookStory:
        return 'facebook';
      case SocialShareSchema.instagramReel:
        return 'instagram';
      case SocialShareSchema.instagramStory:
        return 'instagram';
      case SocialShareSchema.facebook:
        return 'facebook';
    }
  }
}
