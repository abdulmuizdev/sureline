class QuestionEntity {
  final String title;
  final String subTitle;
  final List<String> choices;
  final bool isSkipable;
  final bool isStay;

  const QuestionEntity({
    required this.title,
    required this.subTitle,
    required this.choices,
    this.isSkipable = false,
    this.isStay = false,
  });
}
