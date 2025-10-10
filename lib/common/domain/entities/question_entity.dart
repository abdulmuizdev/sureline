/// Question-related domain entities for the Sureline app.
///
/// This file contains the domain entity for handling interactive questions
/// and surveys within the Sureline app. The [QuestionEntity] represents
/// questions that can be presented to users for feedback, preferences,
/// or onboarding purposes.
///
/// Key Features:
/// - Immutable question data structure
/// - Multiple choice support with customizable options
/// - Skip functionality for optional questions
/// - Stay functionality for persistent questions
/// - Title and subtitle for clear question presentation
///
/// Usage:
/// ```dart
/// final question = QuestionEntity(
///   title: 'What motivates you most?',
///   subTitle: 'Choose the option that resonates with you',
///   choices: ['Success', 'Growth', 'Happiness', 'Achievement'],
///   isSkipable: true,
///   isStay: false,
/// );
/// ```

/// Entity representing an interactive question or survey item.
///
/// This entity is used for creating interactive questions that can be
/// presented to users during onboarding, feedback collection, or preference
/// gathering. It supports multiple choice questions with optional skip
/// and stay functionality.
///
/// Properties:
/// - [title]: The main question text
/// - [subTitle]: Additional context or instructions for the question
/// - [choices]: List of possible answer choices
/// - [isSkipable]: Whether the question can be skipped
/// - [isStay]: Whether the question should remain visible/persistent
///
/// The entity is immutable and designed for easy integration with
/// UI components that present questions to users.
class QuestionEntity {
  /// The main question text.
  ///
  /// This is the primary question that will be displayed to the user.
  final String title;

  /// Additional context or instructions for the question.
  ///
  /// Provides supplementary information to help users understand
  /// how to answer the question.
  final String subTitle;

  /// List of possible answer choices.
  ///
  /// Contains all the options that users can select from.
  /// Should be non-empty for multiple choice questions.
  final List<String> choices;

  /// Whether the question can be skipped.
  ///
  /// If true, users can choose to skip this question without providing an answer.
  /// Defaults to false.
  final bool isSkipable;

  /// Whether the question should remain visible/persistent.
  ///
  /// If true, the question stays visible even after being answered.
  /// Useful for questions that need to be referenced multiple times.
  /// Defaults to false.
  final bool isStay;

  /// Creates a [QuestionEntity] instance.
  ///
  /// [title], [subTitle], and [choices] are required to create a complete question.
  /// [isSkipable] and [isStay] are optional and default to false.
  ///
  /// [title]: The main question text
  /// [subTitle]: Additional context or instructions
  /// [choices]: List of possible answer choices
  /// [isSkipable]: Whether the question can be skipped (defaults to false)
  /// [isStay]: Whether the question should remain visible (defaults to false)
  const QuestionEntity({
    required this.title,
    required this.subTitle,
    required this.choices,
    this.isSkipable = false,
    this.isStay = false,
  });
}
