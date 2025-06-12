import 'package:flutter/material.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/playable.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/bottom_sheets/create_and_edit_theme_bottom_sheet.dart';
import 'package:sureline/features/theme_selection/presentation/main/widgets/theme_selector_item/widget/edit_button.dart';
import 'package:video_player/video_player.dart';

class ThemeSelectorItem extends StatefulWidget {
  final ThemeEntity entity;
  final VoidCallback onPressed;
  final bool isSelected;

  const ThemeSelectorItem({
    super.key,
    required this.entity,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  State<ThemeSelectorItem> createState() => _ThemeSelectorItemState();
}

class _ThemeSelectorItemState extends State<ThemeSelectorItem> {
  // late VideoPlayerController _controller;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    // if (widget.entity.backgroundEntity.isLiveBackground) {
    //   _controller = VideoPlayerController.asset(
    //       widget.entity.backgroundEntity.path!,
    //     )
    //     ..initialize().then((_) {
    //       _controller.setLooping(true);
    //       _controller.setVolume(0);
    //       _controller.play();
    //       setState(() {});
    //     });
    // }
  }

  void _handleTap() async {
    setState(() => _isPressed = true);
    await Future.delayed(Duration(milliseconds: 100));
    setState(() => _isPressed = false);
    widget.onPressed(); // call the original tap handler
  }

  @override
  void dispose() {
    // if (widget.entity.backgroundEntity.isLiveBackground) {
    //   _controller.dispose();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedScale(
          scale: _isPressed ? 0.95 : 1.0,
          duration: Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border:
                  (widget.isSelected)
                      ? Border.all(
                        color: AppColors.primaryColor.withValues(alpha: 0.7),
                      )
                      : null,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  // if (widget.entity.backgroundEntity.isLiveBackground) ...[
                  //   ClipRRect(
                  //     borderRadius: BorderRadius.circular(16),
                  //     child: VideoPlayer(_controller),
                  //   ),
                  //   Align(
                  //     alignment: Alignment.topLeft,
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(7),
                  //       child: Playable(),
                  //     ),
                  //   ),
                  // ] else ...[
                  //   Positioned.fill(
                  //     child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(16),
                  //       child: Image.asset(
                  //         widget.entity.backgroundEntity.path ??
                  //             'assets/images/two.png',
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //   ),
                  // ],
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Background(
                        mute: true,
                        entity: widget.entity.backgroundEntity,
                        isPreview: true,
                      ),
                    ),
                  ),
                  if (widget.isSelected) ...[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(9),
                        child: EditButton(
                          onPressed: () {
                            debugPrint(
                              'edit button is this ${widget.entity.backgroundEntity.isLiveBackground}',
                            );
                            showModalBottomSheet(
                              isScrollControlled: true,
                              useSafeArea: false,
                              context: context,
                              builder:
                                  (context) => CreateAndEditThemeBottomSheet(
                                    entity: widget.entity,
                                  ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                  Center(
                    child: Text(
                      'Sureline',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: widget.entity.textDecorEntity.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
