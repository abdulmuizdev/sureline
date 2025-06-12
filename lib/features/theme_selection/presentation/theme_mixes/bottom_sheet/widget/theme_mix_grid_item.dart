import 'package:flutter/material.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:video_player/video_player.dart';

class ThemeMixGridItem extends StatefulWidget {
  final ThemeEntity entity;

  const ThemeMixGridItem({super.key, required this.entity});

  @override
  State<ThemeMixGridItem> createState() => _ThemeMixGridItemState();
}

class _ThemeMixGridItemState extends State<ThemeMixGridItem> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_){
    if (widget.entity.backgroundEntity.isLiveBackground) {
      _videoPlayerController = VideoPlayerController.asset(
          widget.entity.backgroundEntity.path!,
        )
        ..initialize().then((_) {
          _videoPlayerController.setVolume(0);
          _videoPlayerController.play();
        });
    }
    // });
  }

  @override
  void dispose() {
    if (widget.entity.backgroundEntity.isLiveBackground) {
      _videoPlayerController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child:
                  (!widget.entity.backgroundEntity.isLiveBackground)
                      ? Image.asset(widget.entity.backgroundEntity.path!, fit: BoxFit.cover,)
                      : VideoPlayer(_videoPlayerController),
            ),
          ),

          Center(
            child: Text(
              widget.entity.previewQuote ?? "Sureline",
              style: TextStyle(
                fontSize: 14,
                fontWeight: widget.entity.textDecorEntity.fontWeight,
                color: widget.entity.textDecorEntity.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
