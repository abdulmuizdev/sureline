import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/features/onboarding/home_screen_widget_recom/presentation/pages/home_screen_widget_screen.dart';

class LockScreenWidgetScreen extends StatelessWidget {
  const LockScreenWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(isStatic: true),
          SafeArea(
            child: Column(
              children: [
                OnboardingHeading(
                  title: 'Get quotes without unlocking your phone',
                  subTitle:
                      'Set up widgets to see them on your phone\'s Lock Screen',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  child: Image.asset('assets/images/lock_screen.png'),
                ),
                SurelineButton(
                  disableVerticalPadding: true,
                  text: 'Got it!',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomeScreenWidgetScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
