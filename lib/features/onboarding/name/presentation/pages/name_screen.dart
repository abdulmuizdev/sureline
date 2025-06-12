import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_text_field.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/features/onboarding/benefits/page/benefits_screen.dart';
import 'package:sureline/features/onboarding/name/presentation/bloc/onboarding_name_bloc.dart';
import 'package:sureline/features/onboarding/name/presentation/bloc/onboarding_name_event.dart';
import 'package:sureline/features/onboarding/name/presentation/bloc/onboarding_name_state.dart';
import 'package:sureline/features/onboarding/survey/presentation/pages/survey_screen.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<OnboardingNameBloc>()..add(GetName()))
      ],
      child: BlocListener<OnboardingNameBloc, OnboardingNameState>(
        listener: (context, state){
          if (state is GotName){
            _nameController.text = state.name;
          }
          if (state is NameSaved) {
            HapticFeedback.lightImpact();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (context) => SurveyScreen(
                  entities: App.remoteConfigEntity.survey2,
                  navigateTo: BenefitsScreen(),
                ),
              ),
            );
          }
        },
        child: BlocBuilder<OnboardingNameBloc, OnboardingNameState>(
          builder: (context, state){
            return PopScope(
              canPop: false,
              child: Scaffold(
                body: Stack(
                  children: [
                    Positioned.fill(child: Background()),
                    SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
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
                              context.read<OnboardingNameBloc>().add(OnContinuePressed(_nameController.text));
                            },
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
}
