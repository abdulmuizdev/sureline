import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/common/presentation/widgets/playable.dart';
import 'package:sureline/common/presentation/widgets/tick.dart';
import 'package:video_player/video_player.dart';

/// Widget for displaying individual theme options in the theme selection grid.
/// This component provides a visual preview of each theme with background images,
/// text styling, and selection indicators for the onboarding theme selection process.
///
/// The widget includes animated interactions, support for both static and live backgrounds,
/// and proper state management for selection feedback.
class ThemeGridItem extends StatefulWidget {
  /// The theme entity containing all theme configuration data.
  /// Includes background, text styling, and other visual properties.
  final ThemeEntity entity;

  /// Whether this theme item is currently selected.
  /// Controls the display of the selection indicator (tick mark).
  final bool isSelected;

  /// Callback function triggered when the theme item is tapped.
  /// Handles theme selection and navigation logic.
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
  /// Whether the item is currently being pressed.
  /// Used for scale animation feedback during tap interactions.
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _initializeLiveBackground();
  }

  /// Initializes live background video if the theme uses video backgrounds.
  /// Sets up video player controller for animated theme previews.
  void _initializeLiveBackground() {
    if (widget.entity.backgroundEntity.isLiveBackground) {
      // Video player initialization commented out for performance
      // _controller = VideoPlayerController.asset(
      //   widget.entity.backgroundEntity.path!,
      // )..initialize().then((_) {
      //   _controller.setLooping(true);
      //   _controller.setVolume(0);
      //   _controller.play();
      //   setState(() {});
      // });
    }
  }

  /// Handles tap interactions with animated feedback.
  /// Provides visual feedback through scale animation and delays the callback.
  void _handleTap() async {
    setState(() => _isPressed = true);
    await Future.delayed(Duration(milliseconds: 100));
    setState(() => _isPressed = false);
    widget.onPressed(); // Call the original tap handler
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose(); // Clean up video controller if needed
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
            children: [_buildBackground(), _buildThemeText(), _buildSelectionIndicator()],
          ),
        ),
      ),
    );
  }

  /// Builds the background layer of the theme item.
  /// Handles both static images and live video backgrounds.
  ///
  /// Returns a Widget containing the background content
  Widget _buildBackground() {
    if (widget.entity.backgroundEntity.isLiveBackground) {
      return _buildLiveBackground();
    } else {
      return _buildStaticBackground();
    }
  }

  /// Builds the live background with video player support.
  /// Currently commented out for performance optimization.
  ///
  /// Returns a Widget for live background display
  Widget _buildLiveBackground() {
    return Container(); // Placeholder for video background
    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(16),
    //   child: VideoPlayer(_controller),
    // );
  }

  /// Builds the static background with image asset.
  /// Displays the theme's background image with proper styling.
  ///
  /// Returns a Widget containing the background image
  Widget _buildStaticBackground() {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          widget.entity.backgroundEntity.path ?? 'assets/images/two.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// Builds the theme text overlay with custom styling.
  /// Displays "Sureline" text using the theme's font and color settings.
  ///
  /// Returns a Center widget with styled text
  Widget _buildThemeText() {
    return Center(
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
    );
  }

  /// Builds the selection indicator (tick mark) when the theme is selected.
  /// Only displays when isSelected is true.
  ///
  /// Returns a conditional Align widget with tick indicator
  Widget _buildSelectionIndicator() {
    if (widget.isSelected) {
      return Align(
        alignment: Alignment.topRight,
        child: Padding(padding: const EdgeInsets.all(7), child: Tick()),
      );
    }
    return const SizedBox.shrink();
  }
}
