import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/common/presentation/widgets/playable.dart';
import 'package:sureline/common/presentation/widgets/tick.dart';
import 'package:video_player/video_player.dart';

class ThemeGridItem extends StatefulWidget {
  final ThemeEntity entity;
  final bool isSelected;
  final VoidCallback onPressed;

  const ThemeGridItem({
    super.key,
    required this.entity,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  State<ThemeGridItem> createState() => _ThemeGridItemState();
}

class _ThemeGridItemState extends State<ThemeGridItem> {
  // late VideoPlayerController _controller;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    if (widget.entity.backgroundEntity.isLiveBackground) {
      // _controller = VideoPlayerController.asset(
      //     widget.entity.backgroundEntity.path!,
      //   )
      //   ..initialize().then((_) {
      //     _controller.setLooping(true);
      //     _controller.setVolume(0);
      //     _controller.play();
      //     setState(() {});
      //   });
    }
  }

  void _handleTap() async {
    setState(() => _isPressed = true);
    await Future.delayed(Duration(milliseconds: 100));
    setState(() => _isPressed = false);
    widget.onPressed(); // call the original tap handler
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Stack(
            children: [
              if (widget.entity.backgroundEntity.isLiveBackground) ...[
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(16),
                //   child: VideoPlayer(_controller),
                // ),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: Padding(
                //     padding: const EdgeInsets.all(7),
                //     child: Playable(),
                //   ),
                // ),
              ] else ...[
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      widget.entity.backgroundEntity.path ??
                          'assets/images/two.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],

              Center(
                child: Text(
                  'Sureline',
                  style: GoogleFonts.getFont(
                    widget.entity.textDecorEntity.fontFamily,
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: widget.entity.textDecorEntity.textColor,
                    ),
                  ),
                ),
              ),

              if (widget.isSelected) ...[
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: Tick(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
