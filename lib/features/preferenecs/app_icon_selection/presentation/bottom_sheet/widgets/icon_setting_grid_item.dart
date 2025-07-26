import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/tick.dart';
import 'package:sureline/core/theme/app_colors.dart';

/// Widget for displaying individual app icon options in the icon selection grid.
/// This component provides a visual preview of each app icon with selection
/// indicators and interactive tap handling for the preferences icon selection.
///
/// The widget includes proper styling for selected/unselected states,
/// border decorations, and visual feedback for user interactions.
class IconSettingGridItem extends StatelessWidget {
  /// Whether this icon item is currently selected.
  /// Controls the visual styling and border appearance.
  final bool? isSelected;

  /// The path to the icon image asset to display.
  /// Used to load and display the app icon preview.
  final String iconImage;

  /// Callback function triggered when the icon item is tapped.
  /// Handles icon selection and change logic.
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
      decoration: _buildContainerDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: GestureDetector(onTap: onPressed, child: Stack(children: [_buildIconContent()])),
      ),
    );
  }

  /// Builds the container decoration based on selection state.
  /// Applies different styling for selected and unselected states.
  ///
  /// Returns a BoxDecoration with appropriate styling
  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: (isSelected ?? false) ? AppColors.white.withValues(alpha: 0.5) : null,
      borderRadius: BorderRadius.circular(15),
      border: (isSelected ?? false) ? Border.all(color: AppColors.primaryColor, width: 0.5) : null,
    );
  }

  /// Builds the icon content with image and border styling.
  /// Creates the centered icon display with proper border decoration.
  ///
  /// Returns a Center widget containing the icon image
  Widget _buildIconContent() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.pureWhite, width: 1.5),
        ),
        child: ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.asset(iconImage)),
      ),
    );
  }
}
