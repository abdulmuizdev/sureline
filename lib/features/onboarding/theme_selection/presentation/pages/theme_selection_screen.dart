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

/// Screen for selecting the initial theme during the onboarding process.
/// This screen allows users to choose their preferred visual theme
/// from a grid of available options before proceeding to the next onboarding step.
///
/// The screen includes a grid layout of theme options with visual previews,
/// state management for theme selection, and integration with the onboarding flow.
class ThemeSelectionScreen extends StatefulWidget {
  const ThemeSelectionScreen({super.key});

  @override
  State<ThemeSelectionScreen> createState() => _ThemeSelectionScreenState();
}

class _ThemeSelectionScreenState extends State<ThemeSelectionScreen> {
  /// List of available themes retrieved from the bloc.
  /// Populated when the GotThemes state is received.
  List<ThemeEntity> _themes = [];

  /// Index of the currently selected theme in the grid.
  /// -1 indicates no selection, valid indices correspond to theme array positions.
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => locator<ThemeBloc>()..add(GetThemes()))],
      child: BlocListener<ThemeBloc, ThemeState>(
        listener: (context, state) {
          _handleStateChanges(state);
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
                            child: _buildThemeGrid(context),
                          ),
                        ),
                        _buildContinueButton(),
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

  /// Handles state changes from the ThemeBloc.
  /// Updates local state when themes are loaded and selection changes.
  ///
  /// [state] - The current state from the bloc
  void _handleStateChanges(ThemeState state) {
    if (state is GotThemes) {
      setState(() {
        _themes = state.themes;
        _selectedIndex = state.activeIndex;
      });
      print('Selected index is $_selectedIndex');
    }
  }

  /// Builds the theme grid with available theme options.
  /// Creates a responsive grid layout with theme preview items.
  ///
  /// Returns a GridView.builder widget with theme items
  Widget _buildThemeGrid(BuildContext ctx) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: (110 / 162),
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: _themes.length,
      itemBuilder: (context, index) {
        return ThemeGridItem(
          entity: _themes[index],
          isSelected: _selectedIndex == index,
          onPressed: () {
            _handleThemeSelection(ctx, index);
          },
        );
      },
    );
  }

  /// Handles theme selection from the grid.
  /// Dispatches the ChangeTheme event to the bloc with the selected theme.
  ///
  /// [index] - The index of the selected theme in the grid
  void _handleThemeSelection(BuildContext ctx, int index) {
    ctx.read<ThemeBloc>().add(ChangeTheme(_themes[index]));
  }

  /// Builds the continue button for proceeding to the next onboarding step.
  /// Navigates to the survey screen with specific survey configuration.
  ///
  /// Returns a SurelineButton widget
  Widget _buildContinueButton() {
    return SurelineButton(
      text: 'Continue',
      disableVerticalPadding: true,
      onPressed: () {
        _navigateToSurvey();
      },
    );
  }

  /// Navigates to the survey screen as the next onboarding step.
  /// Uses remote configuration for survey content and sets goals screen as destination.
  void _navigateToSurvey() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder:
            (context) =>
                SurveyScreen(entities: App.remoteConfigEntity.survey4, navigateTo: GoalsScreen()),
      ),
    );
  }
}
