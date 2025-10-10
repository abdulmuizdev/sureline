import 'package:sureline/common/domain/entities/review_entity.dart';

/// Model class for review data.
///
/// This model extends ReviewEntity and provides JSON serialization.
class ReviewModel extends ReviewEntity {
  /// The number of stars in the review.
  final int stars;

  /// The review text content.
  final String reviewText;

  /// Creates a [ReviewModel] instance.
  ReviewModel({required this.stars, required this.reviewText})
    : super(stars: stars, reviewText: reviewText);

  /// Creates a [ReviewModel] from JSON data.
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(stars: json['stars'] as int, reviewText: json['reviewText'] as String);
  }
}
