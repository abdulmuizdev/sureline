import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/skip_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_text_field.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/onboarding/benefits/page/benefits_screen.dart';
import 'package:sureline/features/onboarding/name/presentation/bloc/onboarding_name_bloc.dart';
import 'package:sureline/features/onboarding/name/presentation/bloc/onboarding_name_event.dart';
import 'package:sureline/features/onboarding/name/presentation/bloc/onboarding_name_state.dart';
import 'package:sureline/features/onboarding/survey/presentation/pages/survey_screen.dart';

/// Screen for collecting the user's name during the onboarding process.
/// This screen allows users to enter their preferred name which will be
/// used to personalize their quote experience throughout the app.
///
/// The screen includes state management for name persistence and validation,
/// with options to skip or continue based on user input. It prevents back
/// navigation to ensure users complete the onboarding flow.
class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  /// Controller for managing the name input field text.
  /// Handles user input and provides access to the entered name value.
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => locator<OnboardingNameBloc>()..add(GetName()))],
      child: BlocListener<OnboardingNameBloc, OnboardingNameState>(
        listener: (context, state) {
          _handleStateChanges(state);
        },
        child: BlocBuilder<OnboardingNameBloc, OnboardingNameState>(
          builder: (context, state) {
            return PopScope(
              canPop: false,
              child: Scaffold(
                body: Stack(
                  children: [
                    Positioned.fill(child: Background(isStatic: true)),
                    SafeArea(
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  SkipButton(onTap: _proceed),
                                  OnboardingHeading(
                                    title: 'What do you want to be called?',
                                    subTitle: 'Your name will appear in your quotes',
                                    reduceMargins: true,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 24),
                                    child: SurelineTextField(
                                      isNameInput: true,
                                      controller: _nameController,
                                    ),
                                  ),
                                ],
                              ),
                              SurelineButton(
                                text: 'Continue',
                                onPressed: () {
                                  _handleContinuePressed(context);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Handles state changes from the OnboardingNameBloc.
  /// Updates the UI based on the current state and triggers appropriate actions.
  ///
  /// [state] - The current state from the bloc
  void _handleStateChanges(OnboardingNameState state) {
    if (state is GotName) {
      _nameController.text = state.name;
    }
    if (state is NameSaved) {
      HapticFeedback.lightImpact();
      _proceed();
    }
  }

  /// Handles the continue button press with name validation.
  /// If a name is entered, it saves the name and proceeds. If no name
  /// is entered, it proceeds directly to the next onboarding step.
  ///
  /// [context] - The build context for bloc access
  void _handleContinuePressed(BuildContext context) {
    if (_nameController.text.isNotEmpty) {
      context.read<OnboardingNameBloc>().add(OnContinuePressed(_nameController.text));
    } else {
      _proceed();
    }
  }

  /// Navigates to the next onboarding step (survey screen).
  /// This method handles the transition to the survey step, maintaining
  /// the onboarding flow sequence.
  void _proceed() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder:
            (context) => SurveyScreen(
              entities: App.remoteConfigEntity.survey2,
              navigateTo: BenefitsScreen(),
            ),
      ),
    );
  }
}
