import 'package:sureline/common/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  final int stars;
  final String reviewText;

  ReviewModel({required this.stars, required this.reviewText})
    : super(stars: stars, reviewText: reviewText);

  factory ReviewModel.fromJson(Map<String, dynamic> json) { 
    return ReviewModel(
      stars: json['stars'],
      reviewText: json['reviewText'],
    );
  }
}

