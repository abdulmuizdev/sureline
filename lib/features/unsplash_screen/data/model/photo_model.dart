import 'package:sureline/features/unsplash_screen/domain/entity/photo_entity.dart';

class PhotoModel extends PhotoEntity {
  PhotoModel({
    required super.previewUrl,
    required super.url,
    required super.creditName,
    required super.creditUrl,
    required super.width,
    required super.height,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      previewUrl: json['urls']['small_s3'],
      url: json['urls']['raw'],
      creditUrl: json['user']['links']['html'] ?? '',
      creditName: json['user']['name'] ?? '',
      width: double.parse(json['width'].toString()),
      height: double.parse(json['height'].toString()),
    );
  }
}
