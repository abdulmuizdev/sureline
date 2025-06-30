class MutedContentEntity {
  final String title;
  final bool isSelected;

  MutedContentEntity({required this.title, required this.isSelected});
  MutedContentEntity copyWith({String? title, bool? isSelected}) {
    return MutedContentEntity(
      title: title ?? this.title,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
