import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/core/constants/sureline_icons.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/app_icon_selection/presentation/bottom_sheet/widgets/icon_setting_grid_item.dart';

class AppIconSettingBottomSheet extends StatelessWidget {
  const AppIconSettingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: Utils.bottomSheetDecoration(),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SurelineBackButton(title: 'Sureline'),
          SizedBox(height: 27),
          Text(
            'App icon',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 40),

          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
                crossAxisSpacing: 18,
                mainAxisSpacing: 22
              ),
              itemCount: SurelineIcons.values.length,
              itemBuilder: (context, index) {
                return IconSettingGridItem(
                  isSelected: true,
                  iconImage: SurelineIcons.values[index].previewPath,
                  onPressed: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
