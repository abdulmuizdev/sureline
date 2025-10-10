import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/notifications_settings/domain/entity/day_entity.dart';

class RepeatSelector extends StatefulWidget {
  final Function(List<DayEntity>) onSelectionChange;
  final bool? isFirst;
  final List<DayEntity> days;

  const RepeatSelector({
    super.key,
    required this.onSelectionChange,
    this.isFirst,
    required this.days,
  });

  @override
  State<RepeatSelector> createState() => _RepeatSelectorState();
}

class _RepeatSelectorState extends State<RepeatSelector> {
  late List<DayEntity> _days;

  @override
  void initState() {
    super.initState();
    _days = [...widget.days];
  }

  @override
  void didUpdateWidget(covariant RepeatSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.days != widget.days) {
      _days = [...widget.days];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.white2,
        borderRadius: BorderRadius.only(
          topLeft:
              (widget.isFirst ?? false) ? Radius.circular(10) : Radius.zero,
          topRight:
              (widget.isFirst ?? false) ? Radius.circular(10) : Radius.zero,
        ),
        border: Border(
          bottom: BorderSide(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            width: 0.3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            'Repeat',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(_days.length, (index) {
                return daySelector(
                  _days[index].title,
                  _days[index].isSelected,
                  () {
                    _days[index] = _days[index].copyWith(
                      isSelected: !_days[index].isSelected,
                    );
                    widget.onSelectionChange(_days);
                  },
                );
              }),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

Widget daySelector(String title, bool isEnabled, VoidCallback onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isEnabled ? AppColors.peach : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border:
            (isEnabled)
                ? null
                : Border.all(color: AppColors.primaryColor, width: 1),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color:
                (isEnabled)
                    ? AppColors.primaryColor
                    : AppColors.primaryColor.withValues(alpha: 0.5),
          ),
        ),
      ),
    ),
  );
}
