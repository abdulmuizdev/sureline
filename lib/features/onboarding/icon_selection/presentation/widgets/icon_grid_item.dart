import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/tick.dart';
import 'package:sureline/core/theme/app_colors.dart';

class IconGridItem extends StatelessWidget {
  final bool? isSelected;
  final String iconImage;
  final VoidCallback onPressed;

  const IconGridItem({
    super.key,
    this.isSelected,
    required this.iconImage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            (isSelected ?? false)
                ? AppColors.white.withValues(alpha: 0.4)
                : null,
        borderRadius: BorderRadius.circular(31),
        border:
            (isSelected ?? false)
                ? Border.all(color: AppColors.white, width: 1.5)
                : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(11),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(iconImage,),
                  ),
                ),
                if (isSelected ?? false) ...[
                  Align(
                    alignment: Alignment.topRight,
                    child: Tick(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
