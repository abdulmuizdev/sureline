import 'package:sureline/common/domain/entities/question_entity.dart';

class QuestionModel extends QuestionEntity {
  final String title;
  final String subTitle;
  final List<String> choices;

  const QuestionModel({
    required this.title,
    required this.subTitle,
    required this.choices,
    super.isSkipable = false,
    super.isStay = false,
  }) : super(title: title, subTitle: subTitle, choices: choices);

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      title: json['title'],
      subTitle: json['subTitle'],
      choices: json['choices'],
      isSkipable: json['isSkipable'],
      isStay: json['isStay'],
    );
  }
}
