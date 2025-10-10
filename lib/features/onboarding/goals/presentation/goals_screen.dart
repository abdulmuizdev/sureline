import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/skip_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_text_field.dart';
import 'package:sureline/features/onboarding/interested_catag/presentation/interested_categories_screen.dart';

/// Screen for collecting user goals during the onboarding process.
/// This screen allows users to input their personal goals and aspirations,
/// which helps personalize their quote experience throughout the app.
///
/// The screen includes input validation to ensure users provide meaningful
/// goals, with options to skip or save based on user preference.
class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  /// Controller for managing the goals input field text.
  /// Handles user input and provides access to the entered goals.
  final TextEditingController _goalsController = TextEditingController();

  /// Whether the save goals button should be disabled.
  /// This is controlled by whether the user has entered any text.
  bool _isSaveGoalsButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _goalsController.addListener(() {
        setState(() {
          _isSaveGoalsButtonDisabled = _goalsController.text.isEmpty;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(isStatic: true),

          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SkipButton(
                          onTap: () {
                            _goToNextPage();
                          },
                        ),
                        OnboardingHeading(
                          title: 'What are your goals right now?',
                          subTitle: 'The more you share, the more personalized your quotes will be',
                          reduceMargins: true,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: SurelineTextField(
                            controller: _goalsController,
                            hint: 'I want to...',
                            disableCenterAlignment: true,
                            isTextArea: true,
                            showCharLimit: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SurelineButton(
                  text: 'Save goals',
                  isDisabled: _isSaveGoalsButtonDisabled,

                  onPressed: () {
                    _goToNextPage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Navigates to the next onboarding step (interested categories screen).
  /// This method handles the transition to the next step in the onboarding
  /// flow, regardless of whether goals were saved or skipped.
  void _goToNextPage() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => InterestedCategoriesScreen()));
  }
}
