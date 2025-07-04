import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/features/onboarding/goals/presentation/goals_screen.dart';
import 'package:sureline/features/onboarding/survey/presentation/pages/survey_screen.dart';
import 'package:sureline/features/onboarding/theme_selection/presentation/bloc/theme_bloc.dart';
import 'package:sureline/features/onboarding/theme_selection/presentation/bloc/theme_event.dart';
import 'package:sureline/features/onboarding/theme_selection/presentation/bloc/theme_state.dart';

import '../widgets/theme_grid_item.dart';

class ThemeSelectionScreen extends StatefulWidget {
  const ThemeSelectionScreen({super.key});

  @override
  State<ThemeSelectionScreen> createState() => _ThemeSelectionScreenState();
}

class _ThemeSelectionScreenState extends State<ThemeSelectionScreen> {
  List<ThemeEntity> _themes = [];
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<ThemeBloc>()..add(GetThemes())),
      ],
      child: BlocListener<ThemeBloc, ThemeState>(
        listener: (context, state) {
          if (state is GotThemes) {
            _themes = state.themes;
            _selectedIndex = state.activeIndex;
            print('selected index is $_selectedIndex');
          }
        },
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return Scaffold(
              body: Stack(
                children: [
                  Background(isStatic: true),
                  SafeArea(
                    child: Column(
                      children: [
                        OnboardingHeading(
                          title: 'Which theme would you like to start with?',
                          subTitle:
                              'Choose from a larger selection of theme or create your own later',
                          reduceMargins: true,
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: (110 / 162),
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 4,
                                  ),
                              itemCount: _themes.length,
                              // (_themes.length > 6) ? 6 : _themes.length,
                              itemBuilder: (context, index) {
                                return ThemeGridItem(
                                  entity: _themes[index],
                                  isSelected: _selectedIndex == index,
                                  onPressed: () {
                                    context.read<ThemeBloc>().add(
                                      ChangeTheme(_themes[index]),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),

                        SurelineButton(
                          text: 'Continue',
                          disableVerticalPadding: true,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (context) => SurveyScreen(
                                      entities: App.remoteConfigEntity.survey4,
                                      navigateTo: GoalsScreen(),
                                    ),
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
          },
        ),
      ),
    );
  }
}
