import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/skip_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_text_field.dart';
import 'package:sureline/features/onboarding/interested_catag/presentation/interested_categories_screen.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final TextEditingController _goalsController = TextEditingController();
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
                SkipButton(
                  onTap: () {
                    _goToNextPage();
                  },
                ),
                OnboardingHeading(
                  title: 'What are your goals right now?',
                  subTitle:
                      'The more you share, the more personalized your quotes will be',
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
                Spacer(),
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

  void _goToNextPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => InterestedCategoriesScreen()),
    );
  }
}
