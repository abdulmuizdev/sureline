import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class TextSizeSlider extends StatefulWidget {
  final Function(double) onSliderValueChange;
  final double value;

  const TextSizeSlider({
    super.key,
    required this.onSliderValueChange,
    required this.value,
  });

  @override
  State<TextSizeSlider> createState() => _TextSizeSliderState();
}

class _TextSizeSliderState extends State<TextSizeSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 28,
      child: RotatedBox(
        quarterTurns: -1, // Make it vertical
        child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 100,
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.white,
            trackShape: TaperedSliderTrackShape(),
            // thumbShape: const RoundSliderThumbShape(
            //   enabledThumbRadius: 28 / 2,
            //   disabledThumbRadius: 28 / 2,
            //   elevation: 0,
            //   pressedElevation: 0,
            // ),
            thumbShape: GradientThumbShape(),
            thumbColor: Colors.blueGrey[800],
            overlayColor: Colors.transparent,
          ),
          child: Slider(
            value: widget.value,
            onChanged: (value) => widget.onSliderValueChange(value),
          ),
        ),
      ),
    );
  }
}

class GradientThumbShape extends SliderComponentShape {
  final double thumbRadius;

  GradientThumbShape({this.thumbRadius = 14});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
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
    final Rect thumbRect = Rect.fromCircle(center: center, radius: thumbRadius);

    final Paint borderPaint2 = Paint()
      ..color = AppColors.primaryColor.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1/4;

    context.canvas.drawCircle(center, thumbRadius + 1/2, borderPaint2);

    final Paint paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Color(0xff6D7581),
          Color(0xFF444E5D),
        ],
        center: Alignment.center,
        radius: 0.5
      ).createShader(thumbRect);

    context.canvas.drawCircle(center, thumbRadius, paint);

    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    context.canvas.drawCircle(center, thumbRadius, borderPaint);
  }
}


class TaperedSliderTrackShape extends SliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = true,
    bool isDiscrete = false,
  }) {
    return parentBox.paintBounds;
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = true,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    final Paint paint =
        Paint()
          ..color = sliderTheme.activeTrackColor!
          ..style = PaintingStyle.fill;

    final Size size = parentBox.size;

    // ─── Parameters ─────────────────────────────────────────────────────────────
    const double leftWidth = 8.0 / 2; // Thick side
    const double rightWidth = 16.0 / 2; // Thin side
    const double leftRadius = 4.0;
    const double rightRadius = 8.0;

    final double centerY = offset.dy + size.height / 2;

    // ─── Calculated points ──────────────────────────────────────────────────────
    final double leftTopY = centerY - leftWidth;
    final double leftBottomY = centerY + leftWidth;

    final double rightTopY = centerY - rightWidth;
    final double rightBottomY = centerY + rightWidth;

    final Path path =
        Path()
          // 1️⃣ Top‑left corner (thick radius)
          ..moveTo(offset.dx, leftTopY + leftRadius)
          ..quadraticBezierTo(
            offset.dx,
            leftTopY,
            offset.dx + leftRadius,
            leftTopY,
          )
          // 2️⃣ Top edge toward thin side
          ..lineTo(offset.dx + size.width - rightRadius, rightTopY)
          // 3️⃣ Top‑right corner (thin radius)
          ..quadraticBezierTo(
            offset.dx + size.width,
            rightTopY,
            offset.dx + size.width,
            rightTopY + rightRadius,
          )
          // 4️⃣ Right side down
          ..lineTo(offset.dx + size.width, rightBottomY - rightRadius)
          // 5️⃣ Bottom‑right corner (thin radius)
          ..quadraticBezierTo(
            offset.dx + size.width,
            rightBottomY,
            offset.dx + size.width - rightRadius,
            rightBottomY,
          )
          // 6️⃣ Bottom edge toward thick side
          ..lineTo(offset.dx + leftRadius, leftBottomY)
          // 7️⃣ Bottom‑left corner (thick radius)
          ..quadraticBezierTo(
            offset.dx,
            leftBottomY,
            offset.dx,
            leftBottomY - leftRadius,
          )
          ..close();


    // 1️⃣ Draw Shadow
    final Paint shadowPaint = Paint()
      ..color = AppColors.primaryColor.withValues(alpha: 0.25)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4); // Adjust blur radius

    context.canvas.save();
    context.canvas.translate(-4, 0); // Offset shadow down slightly
    context.canvas.drawPath(path, shadowPaint);
    context.canvas.restore();

    context.canvas.drawPath(path, paint);
  }
}
