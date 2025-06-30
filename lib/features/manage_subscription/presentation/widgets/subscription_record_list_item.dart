import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sureline/core/theme/app_colors.dart';

class SubscriptionRecordListItem extends StatelessWidget {
  final bool showLine;
  final String title;
  final DateTime date;
  const SubscriptionRecordListItem({
    super.key,
    required this.showLine,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            if (showLine) ...[
              Container(
                height: 20,
                width: 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor.withValues(alpha: 0.5),
                ),
              ),
            ],
            Icon(Icons.check_circle, color: AppColors.primaryColor, size: 24),
          ],
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          DateFormat('dd/MM/yyyy').format(date),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
