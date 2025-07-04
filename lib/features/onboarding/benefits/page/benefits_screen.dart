import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/features/onboarding/benefits/widgets/benefit_list_item.dart';
import 'package:sureline/features/onboarding/notification/presentation/page/onboarding_notification_screen.dart';
import 'package:sureline/features/onboarding/survey/presentation/pages/survey_screen.dart';

class BenefitsScreen extends StatelessWidget {
  const BenefitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(isStatic: true),
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  Spacer(),
                  SizedBox(width: 200, height: 200, child: Placeholder()),
                  OnboardingHeading(
                    title: 'The benefits of daily personalized quotes',
                    reduceMargins: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          App.remoteConfigEntity.benefits
                              .map(
                                (benefit) =>
                                    BenefitListItem(benefitText: benefit),
                              )
                              .toList(),
                    ),
                  ),
                  SurelineButton(
                    text: 'Got it!',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => SurveyScreen(
                                entities: App.remoteConfigEntity.survey3,
                                navigateTo: OnboardingNotificationScreen(),
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
