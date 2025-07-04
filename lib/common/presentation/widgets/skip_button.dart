import 'package:flutter/cupertino.dart';
import 'package:sureline/core/theme/app_colors.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onTap;
  const SkipButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 30),
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            'Skip',
            style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
