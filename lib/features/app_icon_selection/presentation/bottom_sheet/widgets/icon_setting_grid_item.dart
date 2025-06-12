import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/tick.dart';
import 'package:sureline/core/theme/app_colors.dart';

class IconSettingGridItem extends StatelessWidget {
  final bool? isSelected;
  final String iconImage;
  final VoidCallback onPressed;

  const IconSettingGridItem({
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
        borderRadius: BorderRadius.circular(10),
        border:
            (isSelected ?? false)
                ? Border.all(color: AppColors.primaryColor, width: 0.51)
                : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: AppColors.pureWhite,
                        width: 0.5,
                      )
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(iconImage,),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
