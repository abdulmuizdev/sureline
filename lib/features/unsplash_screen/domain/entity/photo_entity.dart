/// Domain entity for Unsplash photo data.
///
/// Represents photo metadata including URLs, dimensions, and photographer credits.
/// Used for background image selection and theme customization.
class PhotoEntity {
  /// Preview URL for thumbnail display
  final String previewUrl;

  /// Full resolution image URL
  final String url;

  /// Image width in pixels
  final double width;

  /// Image height in pixels
  final double height;

  /// Photographer name for attribution
  final String creditName;

  /// Photographer profile URL
  final String creditUrl;

  /// Creates PhotoEntity with required photo metadata.
  PhotoEntity({
    required this.previewUrl,
    required this.url,
    required this.creditName,
    required this.creditUrl,
    required this.height,
    required this.width,
  });
}
