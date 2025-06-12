import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/bottom_sheets/confirmation_bottom_sheet/confirmation_bottom_sheet.dart';

class BackButtonWidget extends StatelessWidget {
  final bool isChanged;
  const BackButtonWidget({super.key, required this.isChanged});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (isChanged) {
          showModalBottomSheet(
            isScrollControlled: true,
            useSafeArea: true,
            context: context,
            builder:
                (context) => ConfirmationBottomSheet(
                  onYesPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  onNoPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
          );
        } else {
          Navigator.of(context).pop();
        }
      },
      icon: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: AppColors.white,
        ),
        child: Center(child: Icon(Icons.close_rounded, size: 15)),
      ),
    );
  }
}
