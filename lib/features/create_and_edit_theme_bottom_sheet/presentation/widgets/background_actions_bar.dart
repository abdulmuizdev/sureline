import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class BackgroundActionsBar extends StatelessWidget {
  final VoidCallback onCameraPressed;
  final VoidCallback onUnsplashPressed;
  final VoidCallback onSwatchPressed;

  const BackgroundActionsBar({
    super.key,
    required this.onCameraPressed,
    required this.onUnsplashPressed,
    required this.onSwatchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: onCameraPressed,
            icon: Icon(Icons.camera_alt_rounded, size: 20),
          ),
          IconButton(onPressed: onUnsplashPressed, icon: Icon(Icons.photo_sharp, size: 20)),
          IconButton(onPressed: onSwatchPressed, icon: Icon(Icons.color_lens, size: 30)),
        ],
      ),
    );
  }
}
