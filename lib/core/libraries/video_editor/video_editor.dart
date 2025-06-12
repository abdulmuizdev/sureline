import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VideoEditor {
  static const MethodChannel _channel = MethodChannel(
    'com.abdulmuiz.sureline/render',
  );
  static const _eventChannel = EventChannel(
    'com.abdulmuiz.sureline/facebook_events',
  );

  static void addListener(Function(double, String) onRenderCompleted) {
    _eventChannel.receiveBroadcastStream().listen((event) async {
      // debugPrint(event);
      onRenderCompleted(event['value'] ?? 100, event['filePath'] ?? '');

      if (event['status'] == 'progress') {
        double progress = event['value'];
        // debugPrint("Progress: ${(progress * 100).toStringAsFixed(2)}%");
      } else if (event['status'] == 'completed') {
        debugPrint("Export completed at: ${event['filePath']}");
        debugPrint(event['filePath']);
      }
    });
  }

  static void renderOverlayOnVideo(String videoPath, String imagePath) async {
    await _channel.invokeMethod('addTextOverlay', {
      'videoPath': 'file://$videoPath',
      'textImageURL': 'file://$imagePath',
    });
  }
}
