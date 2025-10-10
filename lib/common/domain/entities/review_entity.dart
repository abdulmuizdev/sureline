/// Review-related domain entities for the Sureline app.

/// Entity representing review data.
class ReviewEntity {
  /// The number of stars in the review (typically 1-5).
  final int stars;

  /// The review text content.
  final String reviewText;

  /// Creates a [ReviewEntity] instance.
  /// [stars] - The star rating (1-5)
  /// [reviewText] - The text content of the review
  const ReviewEntity({required this.stars, required this.reviewText});

  /// Creates a [ReviewEntity] from JSON data.
  /// [json] - The JSON data containing review information
  /// Returns: A new [ReviewEntity] instance
  factory ReviewEntity.fromJson(Map<String, dynamic> json) {
    return ReviewEntity(stars: json['stars'] as int, reviewText: json['reviewText'] as String);
  }
}
