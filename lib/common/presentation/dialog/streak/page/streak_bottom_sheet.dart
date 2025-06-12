import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/streak_container.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/common/domain/entities/streak_display_entity.dart';

class StreakBottomSheet extends StatelessWidget {
  final List<StreakDisplayEntity> entities;
  const StreakBottomSheet({super.key, required this.entities});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: Utils.bottomSheetDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 37,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.primaryColor.withValues(alpha: 0.3),
            ),
          ),
          Spacer(),
          SizedBox(height: 235, width: 235, child: Placeholder()),
          OnboardingHeading(
            title: 'A new daily habit!',
            subTitle:
                'Build a streak to make practicing quotes a habit that sticks!',
            disableMargins: true,
          ),
          StreakContainer(entities: entities,),
          SurelineButton(text: 'I commit to 3 days', onPressed: () {
            Navigator.of(context).pop();
          }),
        ],
      ),
    );
  }
}
