import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sureline/core/libraries/direct_social_share/direct_social_share_schemas.dart';

// appID: 2075312276312408
class DirectSocialShare {
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
            debugPrint(result);
          });
    } catch (e) {
      debugPrint('${e}');
    }
  }

  static void shareMessage(String videoPath) {
    try {
      MethodChannel(
        'com.abdulmuiz.sureline/share',
      ).invokeMethod('shareMessage', {'path': videoPath}).then((result) {
        debugPrint(result);
      });
    } catch (e) {
      debugPrint('${e}');
    }
  }

  static void shareOnTikTok({required String path, required bool isImage}) {
    try {
      MethodChannel('com.abdulmuiz.sureline/share')
          .invokeMethod('shareTikTok', {'path': path, 'isImage': isImage})
          .then((result) {
            debugPrint(result);
          });
    } catch (e) {
      debugPrint('${e}');
    }
  }

  static void shareOnInstagram(String path, bool isImage) {
    try {
      MethodChannel('com.abdulmuiz.sureline/share')
          .invokeMethod('shareInstagram', {'path': path, 'isImage': isImage})
          .then((result) {
            debugPrint(result);
          });
    } catch (e) {
      debugPrint('${e}');
    }
  }

  static void shareOnFacebook({required String videoPath}) {
    try {
      MethodChannel(
        'com.abdulmuiz.sureline/share',
      ).invokeMethod('shareFacebook', {'path': videoPath}).then((result) {
        debugPrint(result);
      });
    } catch (e) {
      debugPrint('${e}');
    }
  }

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
