import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/widgets/text_action_bar/widgets/alignment_selector.dart';

class TextActionsBar extends StatelessWidget {
  final VoidCallback onFontFamilyPressed;
  final VoidCallback onAlignmentPressed;
  final VoidCallback onSwatchPressed;
  final Function(int) onOutlineTextPressed;

  final int outlineState;

  final CrossAxisAlignment alignment;

  const TextActionsBar({
    super.key,
    required this.onFontFamilyPressed,
    required this.onAlignmentPressed,
    required this.onSwatchPressed,
    required this.onOutlineTextPressed,
    required this.alignment,
    required this.outlineState,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: onFontFamilyPressed,
            icon: Text(
              'Aa',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          IconButton(
            onPressed: onSwatchPressed,
            icon: Icon(Icons.color_lens, size: 30),
          ),
          IconButton(
            onPressed: onAlignmentPressed,
            icon: AlignmentSelector(alignment: alignment),
          ),
          IconButton(
            onPressed:
                () => onOutlineTextPressed(_getOutlineState(outlineState)),
            icon: Text(
              'A',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                foreground:
                    (outlineState == 0) ? null : Paint()
                      ?..style = PaintingStyle.stroke
                      ..strokeWidth = double.parse(outlineState.toString())
                      ..color = AppColors.primaryColor,
                color: (outlineState == 0) ? AppColors.primaryColor : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _getOutlineState(int prevState) {
    debugPrint('prev state is this');
    debugPrint('${prevState}');
    if (prevState == 0) {
      return 1;
    } else if (prevState == 1) {
      return 2;
    } else {
      return 0;
    }
  }
}
