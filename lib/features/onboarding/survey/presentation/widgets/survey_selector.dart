import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/common/presentation/widgets/sureline_check_box.dart';

/// Widget for displaying individual survey choices with selection state.
/// This component provides a consistent interface for survey options with
/// optional images, text labels, and visual selection indicators.
///
/// The widget includes proper styling, accessibility features, and
/// visual feedback for selected/unselected states.
class SurveySelector extends StatelessWidget {
  /// The text label for this survey choice.
  /// Displayed as the main content of the selector.
  final String text;

  /// Whether this choice is currently selected.
  /// Controls the visual state of the checkbox indicator.
  final bool isChecked;

  /// Optional image asset to display alongside the text.
  /// Used for visual choice representation when provided.
  final String? imageAsset;

  const SurveySelector({super.key, required this.text, required this.isChecked, this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 7),
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.white, width: 1.5),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_buildContentSection(), SurelineCheckBox(isChecked: isChecked)],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the content section containing image and text.
  /// Handles the layout of optional image and required text content.
  ///
  /// Returns a Row widget with the content elements
  Widget _buildContentSection() {
    return Row(
      children: [
        if (imageAsset != null) ...[_buildImageAsset(), const SizedBox(width: 15)],
        _buildTextContent(),
      ],
    );
  }

  /// Builds the optional image asset widget.
  /// Displays the image with proper sizing and constraints.
  ///
  /// Returns a SizedBox containing the image asset
  Widget _buildImageAsset() {
    return SizedBox(width: 30, height: 30, child: Image.asset(imageAsset!));
  }

  /// Builds the text content widget.
  /// Displays the choice text with proper styling.
  ///
  /// Returns a Text widget with the choice label
  Widget _buildTextContent() {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.primaryColor,
      ),
    );
  }
}
