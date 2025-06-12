import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class BenefitListItem extends StatelessWidget {
  final String benefitText;
  const BenefitListItem({super.key, required this.benefitText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 17),
      child: Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
              child: Placeholder(),
            ),
          ),
          SizedBox(width: 11,),
          Text(
            benefitText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
