import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/skip_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/features/onboarding/interested_catag/domain/entity/category_entity.dart';
import 'package:sureline/features/onboarding/interested_catag/presentation/bloc/category_bloc.dart';
import 'package:sureline/features/onboarding/interested_catag/presentation/bloc/category_event.dart';
import 'package:sureline/features/onboarding/interested_catag/presentation/bloc/category_state.dart';
import 'package:sureline/features/onboarding/interested_catag/presentation/widgets/category_item.dart';
import 'package:sureline/features/onboarding/lock_screen_widget_recom/presentation/pages/lock_screen_widget_screen.dart';
import 'package:sureline/features/onboarding/survey/presentation/pages/survey_screen.dart';

/// Screen for collecting user category preferences during onboarding.
/// This screen allows users to select which quote categories interest them,
/// helping to personalize their quote feed and improve content relevance.
///
/// The screen displays available categories in a wrap layout with
/// toggle functionality, and includes state management for category selection.
class InterestedCategoriesScreen extends StatefulWidget {
  const InterestedCategoriesScreen({super.key});

  @override
  State<InterestedCategoriesScreen> createState() => _InterestedCategoriesScreenState();
}

class _InterestedCategoriesScreenState extends State<InterestedCategoriesScreen> {
  /// List of available categories with their selection states.
  /// This list is populated from the bloc and updated based on user interactions.
  List<CategoryEntity> _categories = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => locator<CategoryBloc>()..add(GetCategories()))],
      child: BlocListener<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is GotCategories) {
            _categories = state.result;
          }
        },
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, snapshot) {
            return Scaffold(
              body: Stack(
                children: [
                  Background(isStatic: true),

                  SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SkipButton(
                          onTap: () {
                            _goToNextPage();
                          },
                        ),
                        OnboardingHeading(
                          title: 'Which categories are you interested in?',
                          subTitle: 'This will be used to personalize your feed',
                          reduceMargins: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Wrap(
                            spacing: 15,
                            runSpacing: 15,
                            children: List.generate(_categories.length, (index) {
                              return CategoryItem(
                                entity: _categories[index],
                                onPressed: () {
                                  _toggleCategorySelection(index);
                                },
                                isSelected: _categories[index].isSelected,
                              );
                            }),
                          ),
                        ),
                        Spacer(),
                        SurelineButton(
                          text: 'Continue',
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
          },
        ),
      ),
    );
  }

  /// Toggles the selection state of a category at the specified index.
  /// This method updates the local state to reflect user category preferences.
  ///
  /// [index] - The index of the category to toggle
  void _toggleCategorySelection(int index) {
    debugPrint('pressed');
    final current = _categories[index];
    setState(() {
      _categories[index] = current.copyWith(isSelected: !current.isSelected);
    });
  }

  /// Navigates to the next onboarding step (survey screen).
  /// This method handles the transition to the survey step, maintaining
  /// the onboarding flow sequence.
  void _goToNextPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder:
            (context) => SurveyScreen(
              entities: App.remoteConfigEntity.survey6,
              navigateTo: LockScreenWidgetScreen(),
            ),
      ),
    );
  }
}
