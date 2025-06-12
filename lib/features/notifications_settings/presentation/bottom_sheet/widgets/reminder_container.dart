import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class ReminderContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final String timeString;
  final bool isSelected;
  final VoidCallback onPressed;
  final Function(bool) onCheckChanged;

  const ReminderContainer({
    super.key,
    required this.title,
    required this.subTitle,
    required this.timeString,
    required this.isSelected,
    required this.onPressed,
    required this.onCheckChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 355,
          height: 92,
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(17),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    timeString,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    subTitle,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                  CupertinoSwitch(value: isSelected, onChanged: onCheckChanged,
                  activeTrackColor: AppColors.green,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
