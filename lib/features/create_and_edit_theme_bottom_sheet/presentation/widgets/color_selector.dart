import 'package:flutter/material.dart';
import 'package:ios_color_picker_with_title/custom_picker/extensions.dart';
import 'package:ios_color_picker_with_title/show_ios_color_picker.dart';
import 'package:sureline/core/theme/app_colors.dart';

class ColorSelector extends StatefulWidget {
  final Color? initialColor;
  final Function(Color) onColorSelected;
  final VoidCallback onBackPressed;

  const ColorSelector({
    super.key,
    required this.onColorSelected,
    this.initialColor,
    required this.onBackPressed,
  });

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  final _colors = [
    Color(0xFF000000),
    Color(0xFF4C4B4B),
    Color(0xFFC6C6C6),
    Color(0xFFFFFFFF),
    Color(0xFFF6C1BE),
    Color(0xFFF98C8C),
    Color(0xFFC70200),
    Color(0xFFE60001),
    Color(0xFFEA4949),
    Color(0xFFEA498C),
    Color(0xFFE6007C),
    Color(0xFFC70277),
    Color(0xFFF98CD4),
    Color(0xFFF6BED9),
    Color(0xFFEDD7E4),
    Color(0xFFD0BEF6),
    Color(0xFFB649EA),
    Color(0xFF9E01C7),
    Color(0xFF6949EA),
    Color(0xFF0400C7),
    Color(0xFF0167C7),
    Color(0xFF4993EA),
    Color(0xFFBEE5F6),
    Color(0xFF8BF9EB),
    Color(0xFF01E6AE),
    Color(0xFF04C7A3),
    Color(0xFF04C72D),
    Color(0xFF86E949),
    Color(0xFFBEF6C1),
    Color(0xFFF6EDBE),
    Color(0xFFF9F48C),
    Color(0xFFEADA48),
    Color(0xFFC7B300),
    Color(0xFFC75F00),
    Color(0xFFEA9649),
    Color(0xFFF9C08C),
    Color(0xFFF6E0BE),
    Color(0xFFEEE5D8),
    Color(0xFF682A00),
    Color(0xFF670000),
    Color(0xFF67003E),
    Color(0xFF460067),
    Color(0xFF001767),
    Color(0xFF003666),
    Color(0xFF016754),
    Color(0xFF1B6600),
    Color(0xFF656701),
  ];
  final IOSColorPickerController iosColorPickerController =
      IOSColorPickerController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: widget.onBackPressed,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.pureWhite,
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primaryColor,
              size: 12,
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          height: 36,
          width: 1,
          color: AppColors.primaryColor.withValues(alpha: 0.1),
        ),
        Expanded(
          child: SizedBox(
            height: 30,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: _colors.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return GestureDetector(
                    onTap: () {
                      iosColorPickerController.showNativeIosColorPicker(
                        darkMode: false,
                        title: "Background Color",
                        startingColor: widget.initialColor,
                        onColorChanged: (color) => widget.onColorSelected(color)
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.pureWhite,
                        ),
                        child: Icon(
                          Icons.color_lens_outlined,
                          color: AppColors.primaryColor,
                          size: 12,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () => widget.onColorSelected(_colors[index - 1]),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: _colors[index - 1],
                          border: Border.all(
                            color: AppColors.pureWhite,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
