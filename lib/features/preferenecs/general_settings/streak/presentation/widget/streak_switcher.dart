import 'package:flutter/cupertino.dart';
import 'package:sureline/core/theme/app_colors.dart';

class StreakSwitcher extends StatelessWidget {
  final bool isSelected;
  final Function(bool) onChange;

  const StreakSwitcher({super.key, required this.isSelected,
  required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          Text(
            'Track streak',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ),
          Spacer(),
          CupertinoSwitch(
            value: isSelected,
            onChanged: onChange,
            activeTrackColor: AppColors.green,
          ),
        ],
      ),
    );
  }
}
