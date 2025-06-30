import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/bloc/icon_bloc.dart';
import 'package:sureline/common/presentation/bloc/icon_event.dart';
import 'package:sureline/common/presentation/bloc/icon_state.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/core/constants/sureline_icons.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/app_icon_selection/presentation/bottom_sheet/widgets/icon_setting_grid_item.dart';
import 'package:sureline/features/onboarding/icon_selection/domain/entity/icon_entity.dart';

class AppIconSettingBottomSheet extends StatefulWidget {
  const AppIconSettingBottomSheet({super.key});

  @override
  State<AppIconSettingBottomSheet> createState() =>
      _AppIconSettingBottomSheetState();
}

class _AppIconSettingBottomSheetState extends State<AppIconSettingBottomSheet> {
  List<IconEntity> _icons = [];
  int? _selectedIndex;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<IconBloc>()..add(Initialize())),
      ],
      child: BlocListener<IconBloc, IconState>(
        listener: (context, state) {
          if (state is ChangedIcon) {
            context.read<IconBloc>().add(Initialize());
          }
          if (state is Initialized) {
            _selectedIndex = state.selectedIndex;
            _icons = state.icons;
          }
          if (state is IconError) {
            debugPrint('error received');
            debugPrint(state.message);
          }
        },

        child: BlocBuilder<IconBloc, IconState>(
          builder: (context, state) {
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
                        mainAxisSpacing: 22,
                      ),
                      itemCount: _icons.length,
                      itemBuilder: (context, index) {
                        return IconSettingGridItem(
                          isSelected: index == _selectedIndex,
                          iconImage: _icons[index].previewPath,
                          onPressed: () {
                            context.read<IconBloc>().add(
                              ChangeIcon(_icons[index]),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
