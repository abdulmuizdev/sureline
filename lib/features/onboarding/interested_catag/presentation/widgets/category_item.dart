import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/onboarding/interested_catag/domain/entity/category_entity.dart';

/// Widget that displays a single category item in the category selection grid.
/// This component renders a category with selection state styling and provides
/// advanced touch handling with drag cancellation for better user experience.
///
/// The widget includes visual feedback for selected state with background
/// highlighting, border styling, and animated icon transitions.
class CategoryItem extends StatefulWidget {
  /// The category entity containing the category data and selection state.
  final CategoryEntity entity;

  /// Callback function triggered when the category is tapped.
  /// Handles the selection logic in the parent component.
  final VoidCallback onPressed;

  /// Whether this category is currently selected by the user.
  /// Controls the visual styling and icon display.
  final bool isSelected;

  const CategoryItem({
    super.key,
    required this.entity,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  /// Whether the user is currently pressing down on the category item.
  /// Used for visual feedback during touch interactions.
  bool _isTapDown = false;

  /// Whether the user has dragged outside the cancellation radius.
  /// Prevents accidental selections when users drag away from the item.
  bool _isDraggingOutsideBounds = false;

  /// The initial position where the user first touched the item.
  /// Used to calculate drag distance for cancellation logic.
  late Offset _initialTapPosition;

  /// The radius within which dragging is allowed before cancellation.
  /// If the user drags beyond this radius, the tap is cancelled.
  final double _cancelRadius = 100.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (details) {
        _initialTapPosition = details.localPosition; // Capture initial position
        setState(() {
          _isTapDown = true;
          _isDraggingOutsideBounds = false; // Reset dragging when tap starts
        });
      },
      onPanEnd: (_) {
        if (_isTapDown) {
          widget.onPressed(); // Manually trigger the tap if still valid
        }
        setState(() {
          _isTapDown = false;
        });
      },
      onTapUp: (_) {
        if (!_isDraggingOutsideBounds) {
          setState(() {
            _isTapDown = false;
          });
        }
      },
      onPanCancel: () {
        setState(() {
          _isTapDown = false;
        });
      },
      onPanUpdate: (details) {
        double distance = (_initialTapPosition - details.localPosition).distance;
        if (distance > _cancelRadius) {
          setState(() {
            _isTapDown = false; // Cancel if out of the radius
            _isDraggingOutsideBounds = true; // Mark as dragging outside the bounds
          });
        } else {
          setState(() {
            _isDraggingOutsideBounds = false; // Still within bounds
          });
        }
      },
      child: Opacity(
        opacity: _isTapDown ? 0.3 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 49,
          decoration: BoxDecoration(
            color: widget.isSelected ? AppColors.white : AppColors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: AppColors.white, width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  transitionBuilder:
                      (child, animation) => FadeTransition(opacity: animation, child: child),
                  child: Icon(
                    widget.isSelected ? Icons.check_rounded : Icons.add_rounded,
                    key: ValueKey<bool>(widget.isSelected),
                    color:
                        widget.isSelected
                            ? AppColors.primaryColor
                            : AppColors.primaryColor.withOpacity(0.5),
                    size: 15,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.entity.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: AppColors.primaryColor,
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
