import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/streak_item.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/common/domain/entities/streak_display_entity.dart';

class StreakContainer extends StatefulWidget {
  final bool? hideText;
  final bool? increaseOpacity;
  final bool? showShare;
  final List<StreakDisplayEntity> entities;
  final VoidCallback? onSharePressed;
  final bool? isShareEnabled;

  const StreakContainer({
    super.key,
    this.hideText,
    this.increaseOpacity,
    required this.entities,
    this.showShare,
    this.onSharePressed,
    this.isShareEnabled
  });

  @override
  State<StreakContainer> createState() => _StreakContainerState();
}

class _StreakContainerState extends State<StreakContainer> {
  late List<bool> _streakSelections;
  late int _indexToAnimate;

  @override
  void initState() {
    super.initState();

    _streakSelections = [
      widget.entities.isNotEmpty,
      widget.entities.length >= 2,
      widget.entities.length >= 3,
      widget.entities.length >= 4,
      widget.entities.length >= 5,
      widget.entities.length >= 6,
      widget.entities.length >= 7,
    ];
    _indexToAnimate = _streakSelections.indexWhere(
      (isChecked) => isChecked == true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 134,
      padding: EdgeInsets.only(bottom: 17),
      decoration: BoxDecoration(
        color: AppColors.pureWhite.withValues(
          alpha: (widget.increaseOpacity ?? false) ? 0.8 : 0.53,
        ),
        border: Border.all(color: AppColors.pureWhite, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Streak',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      IconButton(
                        onPressed: (widget.isShareEnabled ?? false) ? widget.onSharePressed : null,
                        icon: Icon(
                          Icons.ios_share_rounded,
                          size: 20,
                          color: AppColors.primaryColor.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(7, (index) {
                        return StreakItem(
                          isChecked: widget.entities[index].isChecked,
                          day: widget.entities[index].dayLabel,
                          animateSelection: index == _indexToAnimate,
                          isGift: widget.entities[index].isGift,
                          isMissed: widget.entities[index].isMissed,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
            if (!(widget.hideText ?? false)) ...[
              SizedBox(height: 8),
              Text(
                'Come back tomorrow to keep\nyour streak',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
