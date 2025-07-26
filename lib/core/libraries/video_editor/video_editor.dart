import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Video editing functionality.
///
/// This class provides methods for video editing operations including
/// adding overlays and monitoring render progress.
class VideoEditor {
  /// Method channel for video rendering operations.
  static const MethodChannel _channel = MethodChannel('com.abdulmuiz.sureline/render');

  /// Event channel for receiving render progress updates.
  static const _eventChannel = EventChannel('com.abdulmuiz.sureline/facebook_events');

  /// Adds a listener for render completion events.
  ///
  /// Parameters:
  /// - [onRenderCompleted]: Callback function called when rendering completes
  static void addListener(Function(double, String) onRenderCompleted) {
    _eventChannel.receiveBroadcastStream().listen((event) async {
      final eventMap = event as Map<String, dynamic>;
      final value = eventMap['value'] as double? ?? 100.0;
      final filePath = eventMap['filePath'] as String? ?? '';

      onRenderCompleted(value, filePath);

      if (eventMap['status'] == 'progress') {
        final progress = value;
        // debugPrint("Progress: ${(progress * 100).toStringAsFixed(2)}%");
      } else if (eventMap['status'] == 'completed') {
        debugPrint("Export completed at: $filePath");
        debugPrint(filePath);
      }
    });
  }

  /// Renders an overlay on a video.
  ///
  /// Parameters:
  /// - [videoPath]: Path to the input video file
  /// - [imagePath]: Path to the overlay image file
  static void renderOverlayOnVideo(String videoPath, String imagePath) async {
    await _channel.invokeMethod('addTextOverlay', {
      'videoPath': 'file://$videoPath',
      'textImageURL': 'file://$imagePath',
    });
  }
}
