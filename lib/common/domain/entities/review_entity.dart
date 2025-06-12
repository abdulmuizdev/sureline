class ReviewEntity {
    final int stars;
    final String reviewText;

    ReviewEntity({
        required this.stars,
        required this.reviewText,
    }); 

    factory ReviewEntity.fromJson(Map<String, dynamic> json) {
        return ReviewEntity(
            stars: json['stars'],
            reviewText: json['reviewText'],
        );  
    }
}