import 'package:sureline/features/unsplash_screen/domain/entity/photo_entity.dart';

/// Data model for Unsplash photo with JSON serialization.
///
/// Extends PhotoEntity to add JSON parsing from Unsplash API responses.
/// Handles API data transformation and photographer attribution.
class PhotoModel extends PhotoEntity {
  /// Creates PhotoModel with required photo metadata.
  PhotoModel({
    required super.previewUrl,
    required super.url,
    required super.creditName,
    required super.creditUrl,
    required super.width,
    required super.height,
  });

  /// Creates PhotoModel from Unsplash API JSON response.
  /// Parses nested JSON structure for URLs, user data, and dimensions.
  ///
  /// [json] - Unsplash API response JSON
  /// Returns PhotoModel - Parsed photo data
  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    final urls = json['urls'] as Map<String, dynamic>;
    final user = json['user'] as Map<String, dynamic>;
    final userLinks = user['links'] as Map<String, dynamic>;

    return PhotoModel(
      previewUrl: urls['small_s3'] as String,
      url: urls['raw'] as String,
      creditUrl: userLinks['html'] as String? ?? '',
      creditName: user['name'] as String? ?? '',
      width: double.parse((json['width'] as num).toString()),
      height: double.parse((json['height'] as num).toString()),
    );
  }
}
