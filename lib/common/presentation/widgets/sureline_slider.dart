import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sureline/core/theme/app_colors.dart';

class SurelineSlider extends StatelessWidget {
  final double value;
  final Function(double) onChange;
  final Function(double) onChangeEnd;

  const SurelineSlider({
    super.key,
    required this.value,
    required this.onChange,
    required this.onChangeEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.pureWhite,
      ),
      child: SliderTheme(
        data: SliderThemeData(
          activeTrackColor: AppColors.green,
          inactiveTrackColor: AppColors.primaryColor.withValues(alpha: 0.2),
          thumbShape: SliderThumb(),
          overlayColor: Colors.transparent,
          trackShape: TrackShape(),
        ),
        child: Slider(
          allowedInteraction: SliderInteraction.slideThumb,
          value: value,
          onChanged: (newVal) {
            onChange(newVal);
          },
          onChangeStart: (newVal) {
            HapticFeedback.lightImpact();
          },
          onChangeEnd: (newVal) {
            HapticFeedback.lightImpact();
            onChangeEnd(newVal);
          },
        ),
      ),
    );
  }
}

class SliderThumb extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(20, 20);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final Paint paint =
        Paint()
          ..color = AppColors.pureWhite
          ..style = PaintingStyle.fill;

    final Paint paintBorder =
        Paint()
          ..color = AppColors.primaryColor.withValues(alpha: 0.8)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    canvas.drawCircle(center, 10, paintBorder);
    canvas.drawCircle(center, 10, paint);
  }
}

class TrackShape extends RoundedRectSliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 0,
  }) {
    super.paint(
      context,
      offset,
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      enableAnimation: enableAnimation,
      textDirection: textDirection,
      thumbCenter: thumbCenter,
      secondaryOffset: secondaryOffset,
      isDiscrete: isDiscrete,
      isEnabled: isEnabled,
      additionalActiveTrackHeight: additionalActiveTrackHeight,
    );
  }
}
