class QuestionEntity {
  final String title;
  final String subTitle;
  final List<String> choices;

  const QuestionEntity({
    required this.title,
    required this.subTitle,
    required this.choices,
  });
}
