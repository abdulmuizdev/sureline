import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_text_field.dart';
import 'package:sureline/features/onboarding/interested_catag/presentation/interested_categories_screen.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          SafeArea(
            child: Column(
              children: [
                OnboardingHeading(
                  title: 'What are your goals right now?',
                  subTitle:
                      'The more you share, the more personalized your quotes will be',
                  reduceMargins: true,
                ),

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: SurelineTextField(
                    controller: TextEditingController(),
                    hint: 'I want to...',
                    disableCenterAlignment: true,
                    isTextArea: true,
                    showCharLimit: true,
                  ),
                ),
                Spacer(),
                SurelineButton(text: 'Save goals', onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => InterestedCategoriesScreen()));
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
