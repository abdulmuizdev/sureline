import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/onboarding/getting_started/widgets/review_list_item.dart';
import 'package:sureline/features/onboarding/name/presentation/pages/name_screen.dart';
import 'package:sureline/features/onboarding/survey/presentation/pages/survey_screen.dart';

/// Initial onboarding screen that introduces users to Sureline.
/// This screen displays the app's value proposition with an auto-scrolling
/// review carousel and motivational content to engage new users.
///
/// The screen features an animated page view of user reviews and
/// provides the entry point to the complete onboarding flow.
class GettingStartedScreen extends StatefulWidget {
  const GettingStartedScreen({super.key});

  @override
  State<GettingStartedScreen> createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  /// Controller for managing the auto-scrolling review carousel.
  /// Handles the page transitions and animation timing.
  late PageController _controller;

  /// Current page index in the review carousel.
  /// Tracks which review is currently displayed.
  int _currentPage = 0;

  /// Timer for auto-scrolling the review carousel.
  /// Triggers automatic page transitions every 4 seconds.
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.8, initialPage: _currentPage);

    _timer = Timer.periodic(Duration(seconds: 4), _autoScroll);
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  /// Automatically scrolls to the next review in the carousel.
  /// Cycles through all reviews and resets to the first one when
  /// reaching the end of the list.
  ///
  /// [timer] - The timer that triggered this auto-scroll
  void _autoScroll(Timer timer) {
    if (_currentPage < App.remoteConfigEntity.reviews.length - 1) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }

    _controller.animateToPage(
      _currentPage,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(isStatic: true),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/images/excited_man.png'),
                ),
                Spacer(),
                Image.asset('assets/images/achievement_without_num.png', width: 260),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 66),
                  child: Text(
                    'Transform your mindset with positive energy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Spacer(),
                Spacer(),
                SizedBox(
                  height: 70,
                  child: PageView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    itemCount: App.remoteConfigEntity.reviews.length,
                    itemBuilder: (context, index) {
                      return ReviewListItem(
                        starCount: App.remoteConfigEntity.reviews[index].stars,
                        reviewText: App.remoteConfigEntity.reviews[index].reviewText,
                      );
                    },
                  ),
                ),
                Spacer(),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SurelineButton(
                    text: 'Get started',
                    disableVerticalPadding: true,
                    onPressed: () {
                      _navigateToSurvey(context);
                    },
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Navigates to the survey screen as the first step in the onboarding flow.
  /// This method handles the transition from the getting started screen
  /// to the user survey collection, initiating the onboarding sequence.
  ///
  /// [context] - The build context for navigation
  void _navigateToSurvey(BuildContext context) {
    HapticFeedback.lightImpact();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder:
            (context) =>
                SurveyScreen(entities: App.remoteConfigEntity.survey1, navigateTo: NameScreen()),
      ),
    );
  }
}
