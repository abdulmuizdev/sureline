import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/core/app/app.dart';

class PracticeItem extends StatelessWidget {
  final String quote;

  const PracticeItem({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Background()),
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
