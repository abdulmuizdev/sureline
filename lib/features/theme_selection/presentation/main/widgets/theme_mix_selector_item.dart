import 'package:flutter/material.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:video_player/video_player.dart';

class ThemeMixSelectorItem extends StatefulWidget {
  final ThemeEntity entity;
  final bool isSelected;
  final bool isFirst;
  final VoidCallback onPressed;

  const ThemeMixSelectorItem({
    super.key,
    required this.entity,
    required this.isSelected,
    required this.isFirst,
    required this.onPressed
  });

  @override
  State<ThemeMixSelectorItem> createState() => _ThemeMixSelectorItemState();
}

class _ThemeMixSelectorItemState extends State<ThemeMixSelectorItem> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();

    if (widget.entity.backgroundEntity.isLiveBackground) {
      _videoPlayerController = VideoPlayerController.asset(
          widget.entity.backgroundEntity.path!,
        )
        ..initialize().then((_) {
          _videoPlayerController.setVolume(0);
          _videoPlayerController.play();
        });
    }
  }

  @override
  void dispose() {
    if (widget.entity.backgroundEntity.isLiveBackground){
      _videoPlayerController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: (widget.isFirst ? 10 : 0), right: 10),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: 155,
          height: 90,
          // padding: EdgeInsets.symmetric(horizontal: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22),
              topRight: Radius.circular(22),
              bottomLeft: Radius.circular(19.5),
              bottomRight: Radius.circular(19.5),
            ),
            color:
                (widget.isSelected)
                    ? AppColors.primaryColor
                    : AppColors.pureWhite,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                    bottomLeft: Radius.circular(19.5),
                    bottomRight: Radius.circular(19.5),
                  ),
                  child:
                      (!widget.entity.backgroundEntity.isLiveBackground)
                          ? Image.asset(widget.entity.backgroundEntity.path!, fit: BoxFit.cover)
                          : VideoPlayer(_videoPlayerController),
                ),
              ),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.entity.previewQuote ?? "Sureline",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: widget.entity.textDecorEntity.fontWeight,
                        color: widget.entity.textDecorEntity.textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
