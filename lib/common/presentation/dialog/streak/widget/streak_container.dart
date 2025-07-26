import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/streak_item.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/common/domain/entities/streak_display_entity.dart';

/// A widget that displays a streak container with animated streak items.
/// This widget shows the user's current streak progress with interactive
/// elements and optional sharing functionality.
///
/// The container includes a 7-day streak display with individual day items,
/// sharing capabilities, and customizable appearance options for different contexts.
class StreakContainer extends StatefulWidget {
  /// The list of streak display entities to show.
  /// Contains data for each day of the week with their completion status.
  final List<StreakDisplayEntity> entities;

  /// Whether to hide the text below the streak items.
  /// Used to customize the display for different contexts.
  final bool? hideText;

  /// Whether to increase the opacity of the container.
  /// Provides visual emphasis when needed.
  final bool? increaseOpacity;

  /// Whether to show the share button.
  /// Controls the visibility of the sharing functionality.
  final bool? showShare;

  /// Callback function when share button is pressed.
  /// Handles the sharing logic when the user taps the share button.
  final VoidCallback? onSharePressed;

  /// Whether the share functionality is enabled.
  /// Controls whether the share button is interactive.
  final bool? isShareEnabled;

  /// Creates a [StreakContainer] widget.
  const StreakContainer({
    super.key,
    required this.entities,
    this.hideText,
    this.increaseOpacity,
    this.showShare,
    this.onSharePressed,
    this.isShareEnabled,
  });

  @override
  State<StreakContainer> createState() => _StreakContainerState();
}

class _StreakContainerState extends State<StreakContainer> {
  /// List of boolean values representing which streak days are completed.
  /// Used to determine which items should be animated.
  late List<bool> _streakSelections;

  /// Index of the streak item that should be animated.
  /// Determined by finding the first completed streak day.
  late int _indexToAnimate;

  @override
  void initState() {
    super.initState();
    _initializeStreakData();
  }

  /// Initializes the streak data and determines which item to animate.
  /// Sets up the streak selections based on entity data and finds
  /// the appropriate animation target.
  void _initializeStreakData() {
    _streakSelections = [
      widget.entities.isNotEmpty,
      widget.entities.length >= 2,
      widget.entities.length >= 3,
      widget.entities.length >= 4,
      widget.entities.length >= 5,
      widget.entities.length >= 6,
      widget.entities.length >= 7,
    ];
    _indexToAnimate = _streakSelections.indexWhere((isChecked) => isChecked == true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 17),
      decoration: _buildContainerDecoration(),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStreakContent(),
            if (!(widget.hideText ?? false)) ...[const SizedBox(height: 8), _buildStreakText()],
          ],
        ),
      ),
    );
  }

  /// Builds the container decoration with customizable opacity.
  ///
  /// Returns a BoxDecoration with appropriate styling
  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: AppColors.pureWhite.withValues(alpha: (widget.increaseOpacity ?? false) ? 0.8 : 0.53),
      border: Border.all(color: AppColors.pureWhite, width: 1.5),
      borderRadius: BorderRadius.circular(10),
    );
  }

  /// Builds the main streak content including header and streak items.
  ///
  /// Returns a Column widget with streak header and items
  Widget _buildStreakContent() {
    return Column(children: [_buildStreakHeader(), _buildStreakItems()]);
  }

  /// Builds the streak header with title and share button.
  ///
  /// Returns a Padding widget with header content
  Widget _buildStreakHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Your Streak',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
          _buildShareButton(),
        ],
      ),
    );
  }

  /// Builds the share button with conditional functionality.
  ///
  /// Returns an IconButton widget
  Widget _buildShareButton() {
    return IconButton(
      onPressed: (widget.isShareEnabled ?? false) ? widget.onSharePressed : null,
      icon: Icon(
        Icons.ios_share_rounded,
        size: 20,
        color: AppColors.primaryColor.withValues(alpha: 0.5),
      ),
    );
  }

  /// Builds the streak items row with individual day displays.
  ///
  /// Returns a Padding widget with streak items
  Widget _buildStreakItems() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildStreakItemList(),
      ),
    );
  }

  /// Builds the list of streak items for each day of the week.
  ///
  /// Returns a List of StreakItem widgets
  List<Widget> _buildStreakItemList() {
    return List.generate(7, (index) {
      return StreakItem(
        isChecked: widget.entities[index].isChecked,
        day: widget.entities[index].dayLabel,
        animateSelection: index == _indexToAnimate,
        isGift: widget.entities[index].isGift,
        isMissed: widget.entities[index].isMissed,
      );
    });
  }

  /// Builds the streak encouragement text.
  ///
  /// Returns a Text widget with encouragement message
  Widget _buildStreakText() {
    return const Text(
      'Come back tomorrow to keep\nyour streak',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    );
  }
}
