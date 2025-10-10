import 'package:sureline/common/domain/entities/question_entity.dart';

/// Model class for question data.
///
/// This model extends QuestionEntity and provides JSON serialization.
class QuestionModel extends QuestionEntity {
  /// The question title.
  final String title;

  /// The question subtitle.
  final String subTitle;

  /// The list of choices for the question.
  final List<String> choices;

  /// Creates a [QuestionModel] instance.
  const QuestionModel({
    required this.title,
    required this.subTitle,
    required this.choices,
    super.isSkipable = false,
    super.isStay = false,
  }) : super(title: title, subTitle: subTitle, choices: choices);

  /// Creates a [QuestionModel] from JSON data.
  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
      choices: (json['choices'] as List<dynamic>).cast<String>(),
      isSkipable: json['isSkipable'] as bool? ?? false,
      isStay: json['isStay'] as bool? ?? false,
    );
  }
}
