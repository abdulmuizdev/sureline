import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/features/onboarding/home_screen_widget_recom/presentation/pages/home_screen_widget_screen.dart';

/// Screen that introduces users to lock screen widgets during onboarding.
/// This screen explains the benefits of lock screen widgets and provides
/// a visual demonstration of how quotes can be accessed without unlocking the phone.
///
/// The screen serves as an informational step before guiding users to
/// the home screen widget installation process.
class LockScreenWidgetScreen extends StatelessWidget {
  const LockScreenWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(isStatic: true),
          SafeArea(
            child: Column(
              children: [
                const OnboardingHeading(
                  title: 'Get quotes without unlocking your phone',
                  subTitle: 'Set up widgets to see them on your phone\'s Lock Screen',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Image.asset('assets/images/lock_screen.png'),
                ),
                SurelineButton(
                  disableVerticalPadding: true,
                  text: 'Got it!',
                  onPressed: () {
                    _navigateToHomeScreenWidget(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Navigates to the home screen widget installation screen.
  /// This method handles the transition to the next step in the onboarding
  /// flow, where users will be guided through installing home screen widgets.
  ///
  /// [context] - The build context for navigation
  void _navigateToHomeScreenWidget(BuildContext context) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreenWidgetScreen()));
  }
}
