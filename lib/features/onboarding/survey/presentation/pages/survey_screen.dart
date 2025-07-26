import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sureline/common/domain/entities/question_entity.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/skip_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/features/onboarding/survey/presentation/widgets/survey_selector.dart';

/// Screen for collecting user preferences through a multi-step survey during onboarding.
/// This screen presents a series of questions to understand user goals, preferences,
/// and behavior patterns to personalize their quote experience.
///
/// The screen supports both skippable and non-skippable questions, with automatic
/// progression for certain question types and manual continuation for others.
/// It prevents back navigation to ensure users complete the survey flow.
class SurveyScreen extends StatefulWidget {
  /// List of question entities to be presented to the user.
  /// Each entity contains the question text, choices, and configuration options.
  final List<QuestionEntity> entities;

  /// The widget to navigate to after completing all survey questions.
  /// This is typically the next onboarding step.
  final Widget navigateTo;

  /// Current page number in the survey sequence.
  /// Used to track progress and determine which question to display.
  final int pageNumber;

  const SurveyScreen({
    super.key,
    required this.entities,
    required this.navigateTo,
    this.pageNumber = 0,
  });

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  /// Index of the currently selected choice in the current question.
  /// Null when no selection has been made.
  int? _selectedIndex;

  /// Whether the user has made a selection on the current question.
  /// Used to prevent multiple selections and control progression behavior.
  bool _selectionMade = false;

  /// Navigates to the next page in the survey or to the final destination.
  /// Handles both survey progression and completion navigation.
  void _goToNextPage() {
    if (widget.pageNumber < widget.entities.length - 1) {
      _navigateToNextSurveyPage();
    } else {
      _navigateToFinalDestination();
    }
  }

  /// Navigates to the next survey page with incremented page number.
  /// Creates a new instance of SurveyScreen with the next question.
  void _navigateToNextSurveyPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) => SurveyScreen(
              entities: widget.entities,
              navigateTo: widget.navigateTo,
              pageNumber: widget.pageNumber + 1,
            ),
      ),
    );
  }

  /// Navigates to the final destination after survey completion.
  /// This is typically the next onboarding step or main app screen.
  void _navigateToFinalDestination() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => widget.navigateTo));
  }

  /// Builds the survey fragment for the current question.
  /// Handles question display, choice selection, and navigation logic.
  ///
  /// [entity] - The current question entity to display
  /// Returns a Widget containing the complete question interface
  Widget fragment(QuestionEntity entity) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 35, child: _buildSkipButton(entity)),
            OnboardingHeading(title: entity.title, subTitle: entity.subTitle),
            Expanded(child: _buildChoicesList(entity)),
            if (widget.entities[widget.pageNumber].isStay) ...[_buildContinueButton()],
          ],
        ),
      ],
    );
  }

  /// Builds the skip button if the current question is skippable.
  ///
  /// [entity] - The current question entity
  /// Returns a SkipButton widget or empty Container
  Widget _buildSkipButton(QuestionEntity entity) {
    return (widget.entities[widget.pageNumber].isSkipable)
        ? SkipButton(onTap: _goToNextPage)
        : Container();
  }

  /// Builds the list of choices for the current question.
  /// Handles selection logic and progression behavior.
  ///
  /// [entity] - The current question entity
  /// Returns a ListView.builder with choice items
  Widget _buildChoicesList(QuestionEntity entity) {
    return ListView.builder(
      itemCount: entity.choices.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            _handleChoiceSelection(entity, index);
          },
          child: SurveySelector(isChecked: _selectedIndex == index, text: entity.choices[index]),
        );
      },
    );
  }

  /// Handles the selection of a choice in the current question.
  /// Manages state updates and progression logic based on question type.
  ///
  /// [entity] - The current question entity
  /// [index] - The index of the selected choice
  void _handleChoiceSelection(QuestionEntity entity, int index) async {
    if (_selectionMade && !entity.isStay) {
      return;
    }

    setState(() {
      _selectedIndex = index;
      _selectionMade = true;
    });

    if (entity.isStay) {
      return;
    }

    HapticFeedback.lightImpact();
    await Future.delayed(Duration(milliseconds: 1000), () {
      _goToNextPage();
    });
  }

  /// Builds the continue button for questions that require manual progression.
  /// Only shown for questions where isStay is true.
  ///
  /// Returns a SurelineButton widget
  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: SurelineButton(
        text: 'Continue',
        disableVerticalPadding: true,
        onPressed: () {
          _goToNextPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            Background(isStatic: true),
            SafeArea(bottom: false, child: fragment(widget.entities[widget.pageNumber])),
          ],
        ),
      ),
    );
  }
}
