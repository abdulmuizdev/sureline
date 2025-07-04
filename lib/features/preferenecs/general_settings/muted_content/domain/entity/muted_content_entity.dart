class MutedContentEntity {
  final bool isWithAuthorMuted;
  final bool isWithoutAuthorMuted;

  MutedContentEntity({
    required this.isWithAuthorMuted,
    required this.isWithoutAuthorMuted,
  });
  MutedContentEntity copyWith({
    bool? isWithAuthorMuted,
    bool? isWithoutAuthorMuted,
  }) {
    return MutedContentEntity(
      isWithAuthorMuted: isWithAuthorMuted ?? this.isWithAuthorMuted,
      isWithoutAuthorMuted: isWithoutAuthorMuted ?? this.isWithoutAuthorMuted,
    );
  }
}
