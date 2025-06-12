class PhotoEntity {
  final String previewUrl;
  final String url;
  final double width;
  final double height;
  final String creditName;
  final String creditUrl;

  PhotoEntity({
    required this.previewUrl,
    required this.url,
    required this.creditName,
    required this.creditUrl,
    required this.height,
    required this.width
  });
}
