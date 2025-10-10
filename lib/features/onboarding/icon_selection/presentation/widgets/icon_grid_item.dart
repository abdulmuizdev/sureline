import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/tick.dart';
import 'package:sureline/core/theme/app_colors.dart';

/// Widget that displays a single app icon in the icon selection grid.
/// This component renders an app icon with selection state styling and
/// provides touch interaction for icon selection during onboarding.
///
/// The widget includes visual feedback for selected state with background
/// highlighting, border styling, and a tick indicator.
class IconGridItem extends StatelessWidget {
  /// Whether this icon is currently selected by the user.
  /// Controls the visual styling and tick indicator display.
  final bool? isSelected;

  /// The asset path for the icon image to display.
  /// This should point to a valid image asset in the app's assets.
  final String iconImage;

  /// Callback function triggered when the icon is tapped.
  /// Handles the selection logic in the parent component.
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
        color: (isSelected ?? false) ? AppColors.white.withValues(alpha: 0.4) : null,
        borderRadius: BorderRadius.circular(31),
        border: (isSelected ?? false) ? Border.all(color: AppColors.white, width: 1.5) : null,
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
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(iconImage),
                  ),
                ),
                if (isSelected ?? false) ...[
                  const Align(alignment: Alignment.topRight, child: Tick()),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
