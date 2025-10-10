import 'package:flutter/material.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/theme/app_colors.dart';

class DoneButtonWidget extends StatelessWidget {
  final bool isChanged;
  final Duration animationDuration;
  final VoidCallback onPressed;
  const DoneButtonWidget({
    super.key,
    required this.isChanged,
    required this.animationDuration,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isChanged,
      child: AnimatedOpacity(
        opacity: isChanged ? 1 : 0,
        duration: animationDuration,
        child: IconButton(
          onPressed: onPressed,
          icon: Container(
            // width: 100,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: AppColors.white,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text('Done', style: TextStyle(fontSize: 12)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
