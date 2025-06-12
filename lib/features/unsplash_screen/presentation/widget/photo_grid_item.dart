import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/unsplash_screen/domain/entity/photo_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class PhotoGridItem extends StatelessWidget {
  final PhotoEntity photo;
  final VoidCallback onClick;
  const PhotoGridItem({super.key, required this.photo, required this.onClick});

  @override
  Widget build(BuildContext context) {
    final aspectRatio = photo.width / photo.height;

    return GestureDetector(
      onTap: onClick,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: photo.previewUrl,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Container(color: Colors.grey.shade300),
                errorWidget:
                    (context, url, error) =>
                        Icon(Icons.broken_image, color: Colors.grey, size: 40),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: GestureDetector(
                  onTap: () async {
                    debugPrint(photo.creditUrl);
                    final url = Uri.parse(photo.creditUrl);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.inAppWebView);
                    }
                  },
                  child: Text(
                    photo.creditName,
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.pureWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
