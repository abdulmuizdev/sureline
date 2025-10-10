import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/features/onboarding/benefits/widgets/benefit_list_item.dart';
import 'package:sureline/features/onboarding/notification/presentation/page/onboarding_notification_screen.dart';
import 'package:sureline/features/onboarding/survey/presentation/pages/survey_screen.dart';

/// Screen that displays the benefits of using Sureline during onboarding.
/// This screen introduces users to the value proposition of personalized
/// daily quotes and their positive impact on motivation and mindset.
///
/// The screen displays a list of benefits retrieved from remote configuration,
/// allowing for dynamic content updates without app releases. Users can
/// proceed to the next onboarding step (survey) after reviewing the benefits.
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
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset('assets/images/book_reading.png'),
                  ),
                  OnboardingHeading(
                    title: 'The benefits of daily personalized quotes',
                    reduceMargins: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          App.remoteConfigEntity.benefits
                              .asMap()
                              .map(
                                (index, benefit) => MapEntry(
                                  index,
                                  BenefitListItem(
                                    benefitText: benefit,
                                    imagePath: App.remoteConfigEntity.benefitsImages[index],
                                  ),
                                ),
                              )
                              .values
                              .toList(),
                    ),
                  ),
                  SurelineButton(
                    text: 'Got it!',
                    onPressed: () {
                      _navigateToSurvey(context);
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

  /// Navigates to the survey screen as the next step in the onboarding flow.
  /// This method handles the transition from benefits review to user survey
  /// collection, maintaining the onboarding sequence.
  ///
  /// [context] - The build context for navigation
  void _navigateToSurvey(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder:
            (context) => SurveyScreen(
              entities: App.remoteConfigEntity.survey3,
              navigateTo: OnboardingNotificationScreen(),
            ),
      ),
    );
  }
}
