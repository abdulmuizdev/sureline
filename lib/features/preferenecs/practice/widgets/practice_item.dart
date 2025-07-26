import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/core/app/app.dart';

/// Individual quote display widget for practice sessions.
///
/// This widget renders a single quote during practice sessions with
/// full-screen immersive styling. It integrates with the app's theme
/// system to provide consistent visual experience and supports dynamic
/// theming for text appearance, colors, and typography.
///
/// Key Features:
/// - Full-screen quote display with background integration
/// - Dynamic theming support for text styling
/// - Responsive text alignment and sizing
/// - Google Fonts integration for premium typography
/// - Seamless background integration
///
/// Visual Design:
/// - Centered quote text with padding
/// - Dynamic font family, size, and weight from theme
/// - Adaptive text color based on theme
/// - Responsive text alignment
/// - Full-screen background integration
///
/// Theme Integration:
/// - Uses App.themeEntity for dynamic styling
/// - Supports text decoration properties
/// - Integrates with background widget
/// - Maintains visual consistency across sessions
///
/// Usage:
/// ```dart
/// PracticeItem(
///   quote: "Your inspirational quote text here",
/// )
/// ```
class PracticeItem extends StatelessWidget {
  /// The quote text to display during practice session.
  final String quote;

  /// Creates a new PracticeItem instance.
  const PracticeItem({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Full-screen background integration
        Positioned.fill(child: Background()),
        // Centered quote text with theme integration
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              quote,
              textAlign: App.themeEntity.textDecorEntity.textAlign,
              style: GoogleFonts.getFont(
                App.themeEntity.textDecorEntity.fontFamily,
                textStyle: TextStyle(
                  color: App.themeEntity.textDecorEntity.textColor,
                  fontSize: App.themeEntity.textDecorEntity.fontSize,
                  fontWeight: App.themeEntity.textDecorEntity.fontWeight,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
